import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/core/constants/app_enum.dart';
import 'package:gym_app/core/functions/check_internet.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/post_repository.dart';
import 'package:gym_app/features/home/model/post_model.dart';
import 'package:gym_app/features/navigation/persentation/navigation_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find<HomeController>();
  late StatusRequest statusRequest;
  late TextEditingController postController;
  List<PostModel> posts = [];
  late XFile? imageFile;
  final PostRepository postRepository = Get.put(PostRepository());
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final box = GetStorage();
  int commentNumber = 0;
  bool showComment = true;
  int? activeCommentIndex;
  void toggleComment(int index) {
    if (activeCommentIndex == index) {
      activeCommentIndex = null;
    } else {
      activeCommentIndex = index;
    }
    update();
  }

  Future<void> uploadImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (!await checkInternet()) {
          statusRequest = StatusRequest.offline;
          return;
        }
        final finalFile = File(image.path);
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: finalFile.path);
        imageFile = XFile(cropperImage!.path);
        update();
      }
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  Future<void> postFun() async {
    try {
      if (!await checkInternet()) {
        statusRequest = StatusRequest.offline;
        update();
        return;
      }

      statusRequest = StatusRequest.loading;
      update();
      if (imageFile == null) {
        if (!formState.currentState!.validate()) {
          statusRequest = StatusRequest.notValidate;
          update();
          return;
        } else {
          final post = PostModel(
            postText: postController.text,
            imagePath: '',
            videoPath: '',
            userId: FirebaseAuth.instance.currentUser!.uid,
            fullName: box.read('FullName'),
          );

          await postRepository.postAll(post);
          posts.add(post);

          Get.off(() => const NavigationScreen());

          statusRequest = StatusRequest.success;
          update();
          return;
        }
      }

      var random = Random();
      int randomNumber = random.nextInt(100000000);
      final url = await postRepository.postImage(
          '${imageFile.hashCode}$randomNumber', imageFile!);

      final post = PostModel(
        postText: postController.text,
        imagePath: url,
        videoPath: '',
        userId: FirebaseAuth.instance.currentUser!.uid,
        fullName: box.read('FullName'),
      );

      await postRepository.postAll(post);
      posts.insert(0, post);

      Get.off(() => const NavigationScreen());
      statusRequest = StatusRequest.success;
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  DocumentSnapshot? lastDocument;
  bool isLoading = false;
  List<DocumentSnapshot> documents = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchMoreData() async {
    if (isLoading || lastDocument == null) return;
    isLoading = true;

    final QuerySnapshot snapshot = await _firestore
        .collection('yourCollection')
        .startAfterDocument(lastDocument!)
        .limit(10)
        .get();
    final List<DocumentSnapshot> newDocuments = snapshot.docs;
    if (newDocuments.isNotEmpty) {
      lastDocument = newDocuments.last;
      documents.addAll(newDocuments);
    }
    isLoading = false;
  }

  Future<void> getPosts() async {
    try {
      posts = await postRepository.getInitialPosts();
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    getPosts();
    imageFile = null;
    postController = TextEditingController();
    statusRequest = StatusRequest.init;
    super.onInit();
  }
}
