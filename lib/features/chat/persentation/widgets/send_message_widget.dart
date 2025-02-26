import 'package:flutter/material.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';

class SendMessageWidget extends StatelessWidget {
  final int index;
  final bool isChated;
  const SendMessageWidget(
      {super.key, required this.index, required this.isChated});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = ChatController.instance;
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Type a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              await controller.sendMessage(index, isChated);
            },
          ),
        ],
      ),
    );
  }
}
