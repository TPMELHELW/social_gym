import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/core/validation/validation.dart';
import 'package:gym_app/features/auth/controller/signup_controller.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 150,
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          validator: (value) => AppFieldValidator.validateEmpty(
                              value, 'First Name'),
                          controller: controller.firstName,
                          hintText: 'First Name',
                          prefixIcon: const Icon(Iconsax.personalcard),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: CustomTextFormField(
                          validator: (value) => AppFieldValidator.validateEmpty(
                              value, 'Last Name'),
                          hintText: 'Last Name',
                          prefixIcon: const Icon(Iconsax.personalcard),
                          controller: controller.lastName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
            const SizedBox(height: 15),
            GetBuilder<SignupController>(builder: (controller) {
              return MainButton(
                statusRequest: controller.statusRequest,
                text: 'Sign Up',
                onPress: () => controller.signUpWithEmail(),
                textColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.secondary,
              );
            }),
          ],
        ),
      ),
    );
  }
}
