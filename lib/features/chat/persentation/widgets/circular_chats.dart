import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';

class CircularChats extends StatelessWidget {
  const CircularChats({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.userData.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () => controller.userRepository.getAllUsersData(),
              child: CircleAvatar(
                backgroundImage: controller
                        .userData[index].profilePicture.isEmpty
                    ? AssetImage(
                        'assets/images/people.png',
                      )
                    : NetworkImage(controller.userData[index].profilePicture),
                onBackgroundImageError: (value, cc) {
                  print(cc);
                  // print(value.);
                },
                radius: 40,
              ),
            ),
          );
        },
      ),
    );
  }
}
