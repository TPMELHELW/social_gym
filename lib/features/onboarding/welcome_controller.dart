import 'package:get/get.dart';

class WelcomeController extends GetxController {
  static WelcomeController get instance => Get.find<WelcomeController>();

  double opacity = 0.0;

  void _fadeIn() {
    Future.delayed(const Duration(milliseconds: 300), () {
      opacity = 1.0;
      update();
    });
  }

  @override
  void onInit() {
    _fadeIn();
    super.onInit();
  }
}
