import 'package:flutter/material.dart';

class OptionsModel {
  final String title;
  final Icon prefixIcon;
  final void Function()? onPress;

  OptionsModel(
      {required this.title, required this.prefixIcon, required this.onPress});
}
