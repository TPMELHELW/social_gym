import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/persentation/widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return SafeArea(
      child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 20,
          itemBuilder: (context, index) {
            return const PostWidget();
          }),
    );
  }
}
