import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/core/constants/app_enum.dart';
import 'package:gym_app/core/functions/check_internet.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/auth_repository.dart';
import 'package:gym_app/features/navigation/persentation/navigation_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();

  late TextEditingController email, password;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> fpformState = GlobalKey<FormState>();

  late StatusRequest statusRequest;

  final box = GetStorage();
  final AuthRepository _authRepository = Get.put(AuthRepository());

  Future<void> signInWithEmail() async {
    try {
      if (!await checkInternet()) {
        statusRequest = StatusRequest.offline;
        update();
        return;
      }
      if (!formState.currentState!.validate()) {
        statusRequest = StatusRequest.notValidate;
        update();
        return;
      }
      statusRequest = StatusRequest.loading;
      update();

      final cred = await _authRepository.signInWithEmail(
          email.text.trim(), password.text.trim());
      print(cred['UserName']);
      box.write('FullName', cred['UserName']);
      box.write('Email', cred['Email']);

      statusRequest = StatusRequest.success;
      update();
      showSuccessSnackbar('Success', 'Log in Success');
      Get.offAll(const NavigationScreen());
    } catch (e) {
      showErrorSnackbar('Failed', e.toString());
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  Future<void> forgetPassword() async {
    try {
      if (!await checkInternet()) {
        statusRequest = StatusRequest.offline;
        update();
        return;
      }

      if (!fpformState.currentState!.validate()) {
        statusRequest = StatusRequest.notValidate;
        update();
        return;
      }
      statusRequest = StatusRequest.loading;
      update();
      await _authRepository.forgetPassword(email.text.trim());

      statusRequest = StatusRequest.success;
      showSuccessSnackbar('Success', 'Check your Email');
      update();
    } catch (e) {
      statusRequest = StatusRequest.serverFailure;
      update();
      showErrorSnackbar('Error', e.toString());
      print(e);
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    statusRequest = StatusRequest.init;
    super.onInit();
  }
}
