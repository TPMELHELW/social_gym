import 'package:flutter/material.dart';

class CircularChats extends StatelessWidget {
  const CircularChats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              radius: 40,
            ),
          );
        },
      ),
    );
  }
}
