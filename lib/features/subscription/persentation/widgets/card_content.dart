import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/features/subscription/persentation/plans_screen.dart';
import 'package:gym_app/features/subscription/persentation/widgets/my_clipper.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Current Subscribtion',
                  style: TextStyle(fontSize: 35),
                ),
                const Text(
                  '3 Months',
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                  '1/1/2024 > 1/4/2024',
                  style: TextStyle(fontSize: 25),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    '600 EG',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ),
        ),
        Image.asset(
          'assets/images/poke2.png',
          height: 250,
        ),
        MainButton(
          text: 'Change Plan',
          onPress: () => Get.to(() => const PlansScreen()),
        )
      ],
    );
  }
}
