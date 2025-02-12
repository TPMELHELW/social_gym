import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:gym_app/features/chat/persentation/chatting_screen.dart';
import 'package:gym_app/features/home/persentation/home_screen.dart';

class CircularChats extends StatelessWidget {
  const CircularChats({super.key});

  @override
  Widget build(BuildContext context) {
    // final ChatController controller = Get.find<ChatController>();
    return GetBuilder<ChatController>(
        init: ChatController.instance,
        builder: (controller) {
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.userData.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () async {
                      // print('mahoud');
                      // Get.to(() => HomeScreen());
                      // Get.to(() => ChattingScreen(index: index));
                      // pr
                      await controller.getChats(index);
                      Get.to(ChattingScreen(
                        index: index,
                      ));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              controller.userData[index].profilePicture),
                          onBackgroundImageError: (value, cc) {
                            print(cc);
                            // print(value.);
                          },
                          radius: 40,
                          child: controller
                                  .userData[index].profilePicture.isEmpty
                              ? Image.asset(
                                  'assets/images/people.png',
                                  height: 60,
                                )
                              : Image.network(
                                  controller.userData[index].profilePicture),
                        ),
                        Text(controller.userData[index].firstName)
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
