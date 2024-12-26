import 'package:flutter/material.dart';
import 'package:gym_app/features/subscription/persentation/widgets/card_content.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin:
              const EdgeInsets.only(top: 80, bottom: 150, right: 30, left: 30),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const CardContent()),
    );
  }
}
