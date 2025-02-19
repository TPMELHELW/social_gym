import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/data/options_data.dart';

postOptions(BuildContext context, HomeController controller) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Wrap(
        children: optionsData.map((option) {
          return ListTile(
            onTap: option.onPress,
            title: Text(option.title),
            trailing: option.prefixIcon,
          );
        }).toList(),
      ),
    ),
  );
}
