import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:gym_app/features/chat/model/chat_model.dart';
import 'package:gym_app/features/chat/persentation/chatting_screen.dart';
import 'package:iconsax/iconsax.dart';

class VerticalChats extends StatelessWidget {
  const VerticalChats({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController.instance,
        builder: (controller) {
          return FutureBuilder<List<ChatModel>>(
              future: controller.getMessagedFreind(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Start Chat with some freinds'));
                }
                final chats = snapshot.data!;
                return ListView.builder(
                  itemCount: chats.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    log(chats[index].lastMessage.message);
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ChattingScreen(
                              index: index,
                              isChated: true,
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
                                  chats[index].userName,
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  chats[index].lastMessage.message,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Wrap(
                                          children: [
                                            ListTile(
                                              title: Text('Delete Chat'),
                                              trailing:
                                                  Icon(Iconsax.box_remove),
                                              onTap: () => controller
                                                  .deleteChats(index, true),
                                            ),
                                            ListTile(
                                              title: Text('Unfriend'),
                                              trailing:
                                                  Icon(Iconsax.profile_remove),
                                              onTap: () => controller.unfriend(
                                                  index, true),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                                icon: const Icon(Iconsax.more))
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
