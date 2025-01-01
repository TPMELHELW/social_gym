import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_enum.dart';

class MainButton extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  final Color color, textColor;
  final StatusRequest statusRequest;

  const MainButton({
    super.key,
    required this.text,
    this.onPress,
    this.color = Colors.black,
    this.textColor = Colors.white,
    this.statusRequest = StatusRequest.init,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(100, 60),
          ),
          child: statusRequest != StatusRequest.loading
              ? Text(
                  text,
                  style: TextStyle(color: textColor),
                )
              : const CircularProgressIndicator()),
    );
  }
}
