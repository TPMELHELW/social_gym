import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/model/options_model.dart';
import 'package:gym_app/features/share_post/presentation/share_post_screen.dart';
import 'package:iconsax/iconsax.dart';

final HomeController controller = HomeController.instance;

List<OptionsModel> optionsData = [
  OptionsModel(
      title: 'Edit',
      prefixIcon: const Icon(Iconsax.edit),
      onPress: () {
        controller.prefsService.setBool('isEdit', true);
        Get.to(() => const SharePostScreen(
              isEdit: true,
            ));
      }),
  OptionsModel(
      title: 'Remove',
      prefixIcon: const Icon(Iconsax.box_remove),
      onPress: () => controller.deletePost()),
];

// final ChatController _chatController = ChatController.instance;

// List<OptionsModel> chatsOptionsData = [
//   OptionsModel(
//     title: 'Delete Chat',
//     prefixIcon: const Icon(Iconsax.box_remove),
//     onPress: () => _chatController.deleteChats(),
//   ),
//   OptionsModel(
//     title: 'Unfriend',
//     prefixIcon: const Icon(Iconsax.profile_remove),
//     onPress: () {},
//   ),
// ];
