import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/core/constants/app_image_assets.dart';
import 'package:gym_app/core/constants/app_strings.dart';
import 'package:gym_app/features/auth/persentation/login/login_screen.dart';
import 'package:gym_app/features/auth/persentation/signup/signup_screen.dart';
import 'package:gym_app/features/onboarding/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<WelcomeController>(
            init: WelcomeController(),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedOpacity(
                    opacity: controller.opacity,
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      AppStrings.welcomeTo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'cairo',
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  AnimatedOpacity(
                    opacity: controller.opacity,
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset(AppImageAssets.welcomeImage),
                  ),
                  const SizedBox(height: 40),
                  AnimatedOpacity(
                    opacity: controller.opacity,
                    duration: const Duration(milliseconds: 1000),
                    child: MainButton(
                      text: 'Login',
                      textColor: Theme.of(context).colorScheme.primary,
                      color: Theme.of(context).colorScheme.secondary,
                      onPress: () => Get.to(() => const LoginScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: controller.opacity,
                    duration: const Duration(milliseconds: 1000),
                    child: MainButton(
                      text: 'SignUp',
                      onPress: () => Get.to(() => const SignupScreen()),
                      color: Colors.white12,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
