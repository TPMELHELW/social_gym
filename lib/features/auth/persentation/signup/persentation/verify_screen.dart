import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/features/auth/persentation/login/login_screen.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please Chcek Your Email',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              'After Verify Your Email Send Money To This Number And Wait for Approved From Admin',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const SelectableText(
              '+201026271039',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 50),
            MainButton(
              color: Theme.of(context).colorScheme.secondary,
              textColor: Theme.of(context).colorScheme.primary,
              text: 'Continue',
              onPress: () => Get.to(() => const LoginScreen()),
            )
          ],
        ),
      ),
    );
  }
}
