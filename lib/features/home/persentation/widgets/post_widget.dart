import 'package:flutter/material.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/persentation/widgets/comment_section.dart';
import 'package:iconsax/iconsax.dart';

class PostWidget extends StatelessWidget {
  final int index;
  const PostWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController.instance;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                controller.posts[index].fullName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          // Text(
          //   'Time (Now)',
          //   // textAlign: TextAlign.left,
          //   style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          // ),
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            controller.posts[index].postText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart)),
              const Text('100'),
              IconButton(
                  onPressed: () => onCommentPress(context, controller),
                  icon: const Icon(Iconsax.message)),
              const Text('100'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              IconButton(onPressed: () {}, icon: const Icon(Iconsax.share))
            ],
          )
        ],
      ),
    );
  }
}
