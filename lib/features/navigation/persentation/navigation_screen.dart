import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/account_settings/persentation/account_settings_screen.dart';
import 'package:gym_app/features/chat/persentation/chat_screen.dart';
import 'package:gym_app/features/home/persentation/home_screen.dart';
import 'package:gym_app/features/navigation/controller/navigation_controller.dart';
import 'package:gym_app/features/navigation/persentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:gym_app/features/subscription/persentation/subscription_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(controller: controller.tabController, children: const [
            HomeScreen(),
            ChatScreen(),
            SubscriptionScreen(),
            AccountSettingsScreen(),
          ]),
          const BottomNavigationBarWidget(),
        ],
      ),
    );
  }
}
