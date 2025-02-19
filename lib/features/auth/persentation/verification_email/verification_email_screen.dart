import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/core/constants/app_image_assets.dart';
import 'package:gym_app/core/constants/app_strings.dart';
import 'package:gym_app/features/auth/controller/verify_controller.dart';

class VerificationEmailScreen extends StatelessWidget {
  const VerificationEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.put(VerifyController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Verification Your Email'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AppImageAssets.welcomeImage,
          ),
          const Text(
            AppStrings.verifyScreen,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          const Text(
            AppStrings.pleaseCheck,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          MainButton(
            text: 'Continue',
            color: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.tertiary,
            onPress: () async => await controller.checkEmailVerification(),
          ),
          const SizedBox(
            height: 20,
          ),
          MainButton(
            text: 'Resend Email',
            color: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.tertiary,
            onPress: () async => await controller.sendEmailVerification(),
          )
        ],
      ),
    );
  }
}
