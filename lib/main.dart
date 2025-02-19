import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gym_app/core/constants/theme_data.dart';
import 'package:gym_app/core/services/shared_preferences_services.dart';
import 'package:gym_app/data/auth_repository.dart';
import 'package:gym_app/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://odemovknswesjihhkvkc.supabase.co';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SharedPreferencesService());
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9kZW1vdmtuc3dlc2ppaGhrdmtjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzUyMzQzMzUsImV4cCI6MjA1MDgxMDMzNX0.hhy_mREywqFav0LIKOMmR4JNTjfSenHV04IGfI_FK-A',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: ,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
