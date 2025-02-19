import 'package:flutter/material.dart';

class ItemModel {
  final String title;
  final Icon icon;
  final Widget suffixWidget;
  final void Function()? onPress;

  ItemModel({
    required this.title,
    required this.icon,
    this.suffixWidget = const SizedBox(),
    this.onPress,
  });
}
