import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/initial_binding.dart';
import 'package:gym_app/features/auth/persentation/signup/persentation/verify_screen.dart';
import 'package:gym_app/features/navigation/persentation/navigation_screen.dart';
import 'package:gym_app/features/onboarding/welcome_screen.dart';

class AuthRepository extends GetxController {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> signInWith

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const WelcomeScreen());
    } catch (e) {
      rethrow;
    }
  }

  void redirectScreen() {
    if (_auth.currentUser != null) {
      if (!_auth.currentUser!.emailVerified) {
        Get.offAll(() => const VerifyScreen());
      } else {
        Get.offAll(() => const NavigationScreen(), binding: InitialBinding());
      }
    } else {
      Get.offAll(() => const WelcomeScreen());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> signInWithEmail(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // print(_auth.currentUser!.uid);
      final db = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .get();

      return db;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onReady() {
    redirectScreen();
    super.onReady();
  }
}
