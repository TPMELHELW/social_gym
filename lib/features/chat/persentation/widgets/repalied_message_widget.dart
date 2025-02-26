import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';

class RepaliedMessageWidget extends StatelessWidget {
  const RepaliedMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        return controller.repliedMessage != null
            ? Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Icon(Icons.reply, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Replying to: ${controller.repliedMessage!.message}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                      onPressed: controller.clearReply,
                    ),
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }
}
