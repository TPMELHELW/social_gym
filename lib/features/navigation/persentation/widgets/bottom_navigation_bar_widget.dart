import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/navigation/controller/navigation_controller.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(5, 5), blurRadius: 8),
        ],
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        indicatorColor: Colors.white,
        dividerHeight: 0,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
        ),
        tabs: [
          ...List.generate(
            controller.tabBarData.length,
            (int index) => Tab(
              text: controller.tabBarData[index].text,
              icon: controller.tabBarData[index].icon,
              iconMargin: const EdgeInsets.only(bottom: 5),
            ),
          )
        ],
        controller: controller.tabController,
      ),
    );
  }
}
