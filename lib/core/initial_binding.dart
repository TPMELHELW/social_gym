import 'package:get/get.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/account_settings/controller/account_settings_controller.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository());
    Get.put(ChatController());
    Get.put(HomeController());
    Get.put(AccountSettingsController());
  }
}
