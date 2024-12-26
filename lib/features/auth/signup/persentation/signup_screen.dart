import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/features/auth/login/persentation/widgets/custom_divider_widget.dart';
import 'package:gym_app/features/auth/login/persentation/widgets/google_signin_button.dart';
import 'package:gym_app/features/auth/login/persentation/widgets/signup_button_widget.dart';
import 'package:gym_app/features/navigation/persentation/navigation_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 100,
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
            const Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: 'First Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: CustomTextFormField(
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.password),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            MainButton(
              text: 'Sign Up',
              onPress: () => Get.to(() => NavigationScreen()),
              textColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 50),
            const CustomDividerWidget(),
            const SizedBox(height: 50),
            const GoogleSigninButton(),
            const SizedBox(height: 50),
            const SignupButtonWidget(
              isLogin: false,
            )
          ],
        ),
      ),
    );
  }
}
