import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/data/user_repository.dart';
import 'package:gym_app/features/navigation/model/tab_bar_model.dart';
import 'package:iconsax/iconsax.dart';

class NavigationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  static NavigationController get instance => Get.find<NavigationController>();

  List<TabBarModel> tabBarData = [
    TabBarModel(text: 'Home', icon: const Icon(Iconsax.home)),
    TabBarModel(text: 'Chat', icon: const Icon(Iconsax.message)),
    TabBarModel(text: 'Plan', icon: const Icon(Iconsax.money)),
    TabBarModel(text: 'Settings', icon: const Icon(Iconsax.setting))
  ];

  final UserRepository userRepository = UserRepository();

  Future<void> setLastSeen() async {
    try {
      DateTime now = DateTime.now();
      Map<String, dynamic> time = {'LastSeen': now.toString()};
      await userRepository.updateSingleUserInf(time);
      // print(user)
      print(now);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    setLastSeen();
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }
}
