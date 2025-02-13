import 'package:flutter/material.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';

class VerticalChats extends StatelessWidget {
  const VerticalChats({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = ChatController.instance;
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.fetchDocuments();
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
                CircleAvatar(
                  radius: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.sta,
                  children: [
                    Text(
                      'Mahmoud Elhelw',
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'This is Message Here',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
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
  }
}
