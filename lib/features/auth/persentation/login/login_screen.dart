import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/core/validation/validation.dart';
import 'package:gym_app/features/auth/controller/login_controller.dart';
import 'package:gym_app/features/auth/persentation/forget_password/forget_password_screen.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 50,
            ),
            const SizedBox(height: 50),
            Text(
              'Welcome back you\'ve been missed!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            Form(
              key: controller.formState,
              child: Column(
                children: [
                  CustomTextFormField(
                    validator: AppFieldValidator.validateEmail,
                    hintText: 'Email',
                    prefixIcon: const Icon(Iconsax.personalcard),
                    controller: controller.email,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    validator: AppFieldValidator.validatePassword,
                    hintText: 'Password',
                    prefixIcon: const Icon(Iconsax.password_check),
                    controller: controller.password,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.to(() => const ForgetPasswordScreen()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            GetBuilder<LoginController>(builder: (controller) {
              return MainButton(
                statusRequest: controller.statusRequest,
                text: 'Sign In',
                onPress: () => controller.signInWithEmail(),
                textColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.secondary,
              );
            }),
            // const SizedBox(height: 50),
            // const CustomDividerWidget(),
            // const SizedBox(height: 50),
            // const GoogleSigninButton(),
          ],
        ),
      ),
    );
  }
}
