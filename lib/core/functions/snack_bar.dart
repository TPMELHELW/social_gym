import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

SnackbarController showErrorSnackbar(
  String title,
  String text,
) {
  return Get.snackbar(
    title,
    text,
    backgroundColor: Colors.red,
    icon: const Icon(
      Iconsax.close_circle,
      color: Colors.black,
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
  );
}

SnackbarController showSuccessSnackbar(
  String title,
  String text,
) {
  return Get.snackbar(
    title,
    text,
    backgroundColor: Colors.blue,
    icon: const Icon(
      Iconsax.copy_success,
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
  );
}
