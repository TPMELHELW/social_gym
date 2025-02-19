import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color fillColor;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.fillColor = const Color.fromARGB(255, 33, 33, 33),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        // obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
