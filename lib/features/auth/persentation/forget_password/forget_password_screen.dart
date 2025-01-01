import 'package:flutter/material.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/core/validation/validation.dart';
import 'package:gym_app/features/auth/controller/login_controller.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = LoginController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: controller.fpformState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  validator: AppFieldValidator.validateEmail,
                  hintText: 'Email',
                  prefixIcon: const Icon(Iconsax.personalcard),
                  controller: controller.email,
                ),
                const SizedBox(
                  height: 10,
                ),
                MainButton(
                  text: 'Continue',
                  textColor: Theme.of(context).colorScheme.primary,
                  color: Theme.of(context).colorScheme.secondary,
                  onPress: () async => await controller.forgetPassword(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
