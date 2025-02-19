import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:gym_app/features/chat/model/chat_model.dart';
import 'package:gym_app/features/chat/persentation/chatting_screen.dart';

class VerticalChats extends StatelessWidget {
  const VerticalChats({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ChatController.instance,
        builder: (controller) {
          return StreamBuilder<List<ChatModel>>(
              stream: controller.getMessagedFreind(),
              builder: (context, snapshot) {
                print('fff');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No chats available.'));
                }

                final chats = snapshot.data!.toSet().toList();
                // print(chats[0].);
                return ListView.builder(
                  itemCount: chats.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await controller.getChats(index, true);
                        Get.to(() => ChattingScreen(
                              index: index,
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 22,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.chatedUserData[index].userName,
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  controller.chatedUserData[index].lastMessage
                                      .message,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
        });
  }
}
