import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/account_settings/controller/account_settings_controller.dart';
import 'package:iconsax/iconsax.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountSettingsController controller =
        Get.put(AccountSettingsController());
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          const Text(
            'Settings',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              const Expanded(
                // Use Expanded to make the Column take only the necessary space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mahmoud Elhelw',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'mahmoudtarekelhelw1234@gmail.com',
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Iconsax.arrow_right))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 60),
            // height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(15)),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.itemData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: controller.itemData[index].icon,
                  title: Text(controller.itemData[index].title),
                  trailing: controller.itemData[index].suffixWidget,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
