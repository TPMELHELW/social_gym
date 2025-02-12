import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/core/constants/app_enum.dart';
import 'package:gym_app/core/functions/check_internet.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/post_repository.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:gym_app/features/home/model/comment_model.dart';
import 'package:gym_app/features/home/model/post_model.dart';

class HomeController extends GetxController {
  ///Veriable
  static HomeController get instance => Get.find<HomeController>();
  final ScrollController scrollController = ScrollController();
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final PostRepository postRepository = Get.put(PostRepository());
  final GlobalKey<FormState> commentFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> secondCommentFormState = GlobalKey<FormState>();
  final UserRepository userRepository = Get.put(UserRepository());
  final box = GetStorage();
  late UserModel userData;
  late TextEditingController commentController;
  late TextEditingController secondCommentController;
  late StatusRequest statusRequest;
  bool _hasMoreData = true;
  bool showComment = true;
  List<PostModel> posts = [];
  int? activeCommentIndex;
  int commentNumber = 0;
  int currentPost = 0;

  ///Delete Post
  Future<void> deletePost() async {
    try {
      await postRepository.deletePost(posts[currentPost].postId);
      posts.removeAt(currentPost);
      Get.back();
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Functions
  void toggleComment(int index) {
    if (activeCommentIndex == index) {
      activeCommentIndex = null;
    } else {
      activeCommentIndex = index;
    }
    update();
  }

  ///Get All Posts Fun
  Future<void> _fetchData() async {
    if (!_hasMoreData) return;

    final snapshot = await postRepository.getAllPosts();
    if (snapshot.docs.length < 10) {
      _hasMoreData = false;
    }
    final docs = snapshot.docs;
    final data = docs
        .map((value) => PostModel.fromSnapshot(
            value as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
    posts.addAll(data);

    update();
  }

  ///Add Comment Fun
  Future<void> addComment(int mainIndex, int? index) async {
    try {
      if (!await checkInternet()) {
        return;
      }

      var post = {};
      if (index == null) {
        if (!commentFormState.currentState!.validate()) {
          return;
        }
        final comment = CommentModel(
            fullName: box.read('FullName'),
            commentText: commentController.text,
            likes: [],
            userId: currentUser,
            comments: []);
        posts[mainIndex].comments.add(comment);

        post = posts[mainIndex].toJson();
        update();
      } else {
        if (!secondCommentFormState.currentState!.validate()) {
          return;
        }
        final comment = CommentModel(
            fullName: box.read('FullName'),
            commentText: secondCommentController.text,
            likes: [],
            userId: currentUser,
            comments: []);
        posts[mainIndex].comments[index].comments.add(comment);

        post = posts[mainIndex].toJson();
        update();
      }
      await postRepository.postUpdate(posts[mainIndex].postId, post);
      commentController.clear();
      secondCommentController.clear();
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Add Friend
  Future<void> addFriend(index) async {
    try {
      userData.friendList.add(posts[index].userId);
      await userRepository.updateSingleUserInf(userData.toJson());
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Remove Friend
  Future<void> removeFriend(index) async {
    try {
      userData.friendList.remove(posts[index].userId);
      await userRepository.updateSingleUserInf(userData.toJson());
      update();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  ///Likes Fun
  Future<void> likeFun(
    int postIndex,
    int? commentIndex,
    int? commentOfCommentIndex,
  ) async {
    try {
      List currentPost = posts[postIndex].likes;

      if (commentIndex != null) {
        if (commentOfCommentIndex == null) {
          currentPost = posts[postIndex].comments[commentIndex].likes;
        } else {
          currentPost = posts[postIndex]
              .comments[commentIndex]
              .comments[commentOfCommentIndex]
              .likes;
        }
      }

      if (currentPost.contains(currentUser)) {
        currentPost.remove(currentUser);
        update();
      } else {
        currentPost.add(currentUser);
        update();
      }
      final data = posts[postIndex].toJson();
      await postRepository.postUpdate(posts[postIndex].postId, data);
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  @override
  void onInit() {
    commentController = TextEditingController();
    secondCommentController = TextEditingController();
    // final ss = box.read('UserData');
    // print(ss['FirstName']);
    print(box.read('UserData'));
    userData = UserModel.fromStorage(box.read('UserData'));
    // print(userData.email);
    // print(userData.friendList);
    statusRequest = StatusRequest.init;
    scrollController.addListener(_scrollListener);
    _fetchData();
    super.onInit();
  }
}
