import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:gym_app/features/chat/persentation/chatting_screen.dart';

class CircularChats extends StatelessWidget {
  const CircularChats({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController.instance,
        builder: (controller) {
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.friendData.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ChattingScreen(
                        index: index,
                        isChated: false,
                      ));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              controller.friendData[index].profilePicture),
                          onBackgroundImageError: (value, cc) {
                            print(cc);
                            // print(value.);
                          },
                          radius: 40,
                          child: controller
                                  .friendData[index].profilePicture.isEmpty
                              ? Image.asset(
                                  'assets/images/people.png',
                                  height: 60,
                                )
                              : Image.network(
                                  controller.friendData[index].profilePicture),
                        ),
                        Text(controller.friendData[index].firstName)
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
