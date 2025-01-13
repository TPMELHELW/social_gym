import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:gym_app/features/chat/persentation/widgets/circular_chats.dart';
import 'package:gym_app/features/chat/persentation/widgets/vertical_chats.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 20, bottom: 100),
        children: const [
          Text(
            'Chat',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
          CircularChats(),
          SizedBox(
            height: 10,
          ),
          VerticalChats()
        ],
      ),
    );
  }
}
