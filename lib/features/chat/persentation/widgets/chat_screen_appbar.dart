import 'package:flutter/material.dart';
import 'package:gym_app/features/chat/controller/chat_controller.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isChated;
  final int index;
  const ChatScreenAppbar(
      {super.key, required this.isChated, required this.index});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = ChatController.instance;
    return AppBar(
      title: Row(
        children: [
          const CircleAvatar(
            radius: 17,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isChated
                    ? controller.chatedUserData[index].userName
                    : controller.friendData[index].firstName,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                controller.getLastSeen(index),
                style: const TextStyle(fontSize: 12),
              ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
