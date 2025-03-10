import 'package:flutter/material.dart';
import 'package:gym_app/core/components/main_button.dart';
import 'package:gym_app/features/subscription/persentation/widgets/my_clipper.dart';

class PlansCardWidget extends StatelessWidget {
  final String months, date, price, imagePath;
  final void Function()? onPress;
  const PlansCardWidget({
    super.key,
    required this.months,
    required this.date,
    required this.price,
    required this.imagePath,
    this.onPress,
  });

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
                Text(
                  months,
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 25),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    price,
                    style: const TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ),
        ),
        Image.asset(
          imagePath,
          height: 250,
        ),
        MainButton(
          text: 'Select Plan',
          onPress: onPress,
        )
      ],
    );
  }
}
