import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/constants/theme_data.dart';
import 'package:gym_app/features/onboarding/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const WelcomeScreen(),
    );
  }
}
