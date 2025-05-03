import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/functions/snack_bar.dart';
import 'package:gym_app/data/auth_repository.dart';
import 'package:gym_app/features/subscription/persentation/plans_screen.dart';

class VerifyController extends GetxController {
  @override
  void onInit() {
    autoDirect();
    super.onInit();
  }

  final _auth = FirebaseAuth.instance;
  Future<void> autoDirect() async {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      await _auth.currentUser!.reload();
      if (_auth.currentUser!.emailVerified) {
        timer.cancel();
        Get.off(() => const PlansScreen());
      }
    });
  }

  Future<void> checkEmailVerification() async {
    if (_auth.currentUser != null && _auth.currentUser!.emailVerified) {
      Get.off(() => const PlansScreen());
    } else {
      showErrorSnackbar('Not Verify', 'Please verify your email');
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await AuthRepository().sendEmailVerification();
    } catch (e) {
      showErrorSnackbar('Error', e.toString());
    }
  }
}
