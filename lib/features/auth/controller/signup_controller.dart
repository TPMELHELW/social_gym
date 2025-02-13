import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/constants/app_enum.dart';
import 'package:gym_app/core/functions/check_internet.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/auth_repository.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:gym_app/features/auth/persentation/verification_email/verification_email_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find<SignupController>();

  late TextEditingController email, password, firstName, lastName;
  late StatusRequest statusRequest;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  final AuthRepository _authRepository = Get.put(AuthRepository());

  Future<void> signUpWithEmail() async {
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
      final user = await _authRepository.signUpWithEmail(
          email.text.trim(), password.text.trim());
      final userData = UserModel(
        id: user.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text.trim(),
        number: '',
        userName: '${firstName.text.trim()} ${lastName.text.trim()}',
        profilePicture: '',
        isApproved: false,
        plan: '',
        friendList: [],
        // lastSeen: Timestamp(0, 0),
      );

      await UserRepository().saveUserInf(userData);

      await _authRepository.sendEmailVerification();
      Get.to(() => const VerificationEmailScreen());

      showSuccessSnackbar('Success', 'Check Your Email');
      statusRequest = StatusRequest.success;
      update();
    } catch (e) {
      print(e);
      showErrorSnackbar('Failed', e.toString());
      statusRequest = StatusRequest.serverFailure;
      update();
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    statusRequest = StatusRequest.init;
    super.onInit();
  }
}
