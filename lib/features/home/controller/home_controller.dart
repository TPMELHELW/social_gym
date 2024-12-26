import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find<HomeController>();

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
}
