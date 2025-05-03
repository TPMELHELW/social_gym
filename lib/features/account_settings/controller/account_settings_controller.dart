import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/data/auth_repository.dart';
import 'package:gym_app/features/account_settings/model/item_model.dart';
import 'package:iconsax/iconsax.dart';

class AccountSettingsController extends GetxController {
  static AccountSettingsController get instance =>
      Get.find<AccountSettingsController>();

  final List<ItemModel> itemData = [
    ItemModel(title: 'Dark Mode', icon: const Icon(Iconsax.moon)),
    ItemModel(
        title: 'Account Settings', icon: const Icon(Iconsax.personalcard)),
    ItemModel(
        title: 'Log Out',
        icon: const Icon(Iconsax.logout),
        onPress: () => AuthRepository().logOut()),
    ItemModel(
        title: 'Contact With Us', icon: const Icon(Iconsax.cloud_connection)),
    ItemModel(
        title: 'Delete Account', icon: const Icon(Iconsax.profile_delete)),
    ItemModel(title: 'About', icon: const Icon(Iconsax.info_circle)),
  ];
}
