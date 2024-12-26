import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/subscription/controller/subscribtion_controller.dart';
import 'package:gym_app/features/subscription/persentation/widgets/plans_card_widget.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscribtionController controller = Get.put(SubscribtionController());
    return Scaffold(
      body: PageView.builder(
          itemCount: controller.pageData.length,
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 80, bottom: 150, right: 30, left: 30),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: PlansCardWidget(
                    months: controller.pageData[index].months,
                    date: controller.pageData[index].date,
                    price: controller.pageData[index].price,
                    imagePath: controller.pageData[index].imagePath,
                  )),
            );
          }),
    );
  }
}
