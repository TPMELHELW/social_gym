import 'package:flutter/material.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/persentation/widgets/comment_section.dart';
import 'package:iconsax/iconsax.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

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
                'Mahmoud Elhelw',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              Text(
                'Time (Now)',
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SelectableText(
            'The Post Text Or Video',
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
