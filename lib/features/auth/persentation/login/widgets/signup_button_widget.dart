import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/auth/persentation/login/login_screen.dart';
import 'package:gym_app/features/auth/persentation/signup/signup_screen.dart';

class SignupButtonWidget extends StatelessWidget {
  final bool isLogin;
  const SignupButtonWidget({super.key, this.isLogin = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Not a member?' : 'Have Account?',
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: () => isLogin
              ? Get.off(() => const SignupScreen())
              : Get.off(() => const LoginScreen()),
          child: Text(
            isLogin ? 'Register now' : 'Login now',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
