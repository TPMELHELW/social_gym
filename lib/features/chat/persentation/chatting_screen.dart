import 'package:flutter/material.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:iconsax/iconsax.dart';

class ChattingScreen extends StatelessWidget {
  final int index;
  const ChattingScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = ChatController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 17,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.userData[index].firstName,
                    style: const TextStyle(fontSize: 16)),
                // Text(controller.getLastSeen(index),
                //     style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.more),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Iconsax.backward),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  // print(controller.chats[index].message);
                  return GestureDetector(
                    onHorizontalDragEnd: (detail) {
                      print('dd');
                    },
                    child: Column(
                      crossAxisAlignment: controller.chats[index].id ==
                              controller.userRepository.auth!.uid
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(50),
                          elevation: 10,
                          color: Theme.of(context).colorScheme.tertiary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(controller.chats[index].message),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          BottomAppBar(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async => await controller.sendMessage(index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
