import 'package:flutter/material.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:gym_app/features/chat/model/message_model.dart';
import 'package:gym_app/features/chat/persentation/widgets/chat_screen_appbar.dart';
import 'package:gym_app/features/chat/persentation/widgets/message_widget.dart';
import 'package:gym_app/features/chat/persentation/widgets/repalied_message_widget.dart';
import 'package:gym_app/features/chat/persentation/widgets/send_message_widget.dart';

class ChattingScreen extends StatelessWidget {
  final int index;
  final bool isChated;
  // final  userId;
  const ChattingScreen({
    super.key,
    required this.index,
    required this.isChated,
    // required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final ChatController controller = ChatController.instance;
    return Scaffold(
      appBar: ChatScreenAppbar(
        isChated: isChated,
        index: index,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          StreamBuilder<List<MessageModel>>(
            stream: controller.getChats(index, isChated),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.white,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No chats available.'));
              }

              final data = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final message = data[index];
                    final isMe =
                        message.id == controller.userRepository.auth!.uid;

                    return MessageWidget(
                      isMe: isMe,
                      message: message,
                    );
                  },
                ),
              );
            },
          ),
          const RepaliedMessageWidget(),
          SendMessageWidget(
            index: index,
            isChated: isChated,
          )
        ],
      ),
    );
  }
}
