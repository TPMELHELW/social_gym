import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/core/constants/app_enum.dart';
import 'package:gym_app/core/functions/check_internet.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/post_repository.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/model/post_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SharePostController extends GetxController {
  static SharePostController get instance => Get.find<SharePostController>();
  late StatusRequest statusRequest;
  late XFile? imageFile;
  late TextEditingController postController;
  final HomeController _homeController = HomeController.instance;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final box = GetStorage();
  late final currentDataUser;
  final PostRepository postRepository = Get.put(PostRepository());
  bool isEdit = false;

  ///Share Post Fun
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
            likes: [],
            comments: [],
            time: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
          );

          final data = await postRepository.postAll(post);
          final ss = await data.get();
          final newData = PostModel.fromSnapshot(ss);
          _homeController.posts.insert(0, newData);
          Get.back();
          statusRequest = StatusRequest.success;
          _homeController.update();
          return;
        }
      }
      var random = Random();
      int randomNumber = random.nextInt(100000000);
      final url = await postRepository.postImage(
          '${imageFile.hashCode}$randomNumber', imageFile!);

      final post = PostModel(
        time: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        postText: postController.text,
        imagePath: url,
        videoPath: '',
        userId: FirebaseAuth.instance.currentUser!.uid,
        fullName: currentDataUser.fullName,
        likes: [],
        comments: [],
      );
      final data = await postRepository.postAll(post);
      final ss = await data.get();
      final newData = PostModel.fromSnapshot(ss);
      _homeController.posts.insert(0, newData);
      Get.back();
      statusRequest = StatusRequest.success;
      _homeController.update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  ///Upload Image Fun
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

  ///Edit Post
  Future<void> editPost() async {
    try {
      final post = _homeController.posts[_homeController.currentPost];
      if (imageFile == null) {
        if (!formState.currentState!.validate()) {
          statusRequest = StatusRequest.notValidate;
          update();
          return;
        } else {
          post.postText = postController.text;
          await postRepository.postUpdate(post.postId, post.toJson());
          Get.back();
          Get.back();
          statusRequest = StatusRequest.success;
          _homeController.update();
          print('success');
          return;
        }
      }
      var random = Random();
      int randomNumber = random.nextInt(100000000);
      final url = await postRepository.postImage(
          '${imageFile.hashCode}$randomNumber', imageFile!);

      post.postText = postController.text;
      post.imagePath = url;
      await postRepository.postUpdate(post.postId, post.toJson());

      Get.back();
      Get.back();

      statusRequest = StatusRequest.success;
      _homeController.update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    imageFile = null;
    postController = TextEditingController();
    postController.text = box.read('isEdit')
        ? _homeController.posts[_homeController.currentPost].postText
        : '';
    currentDataUser = box.read('UserData');
    statusRequest = StatusRequest.init;
    super.onInit();
  }
}
