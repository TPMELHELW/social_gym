import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/features/auth/model/user_model.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/persentation/widgets/comment_section.dart';
import 'package:gym_app/features/home/persentation/widgets/post_options.dart';
import 'package:iconsax/iconsax.dart';

class PostWidget extends StatelessWidget {
  final int index;
  const PostWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController.instance;
    bool like = controller.posts[index].likes.contains(controller.currentUser);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.posts[index].fullName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    controller.posts[index].time,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ],
              ),
              const Spacer(),
              FutureBuilder<UserModel>(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                          child: Text('Start Chat with some freinds'));
                    }

                    final data = snapshot.data!;
                    return controller.currentUser ==
                            controller.posts[index].userId
                        ? IconButton(
                            onPressed: () {
                              controller.currentPost = index;
                              postOptions(context, controller);
                            },
                            icon: const Icon(Iconsax.more),
                            style: IconButton.styleFrom(
                                alignment: Alignment.centerRight),
                          )
                        : data.friendList
                                .contains(controller.posts[index].userId)
                            ? IconButton(
                                onPressed: () => controller.removeFriend(index),
                                icon: const Icon(Iconsax.profile_remove))
                            : IconButton(
                                onPressed: () => controller.addFriend(index),
                                icon: const Icon(Iconsax.profile_add));
                  })
            ],
          ),
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
          controller.posts[index].imagePath.isEmpty
              ? const SizedBox()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(controller.posts[index].imagePath)),
          Row(
            children: [
              IconButton(
                  onPressed: () => controller.likeFun(index, null, null),
                  icon: Icon(like ? CupertinoIcons.heart_fill : Iconsax.heart)),
              Text(controller.posts[index].likes.length.toString()),
              IconButton(
                  onPressed: () => onCommentPress(context, controller, index),
                  icon: const Icon(Iconsax.message)),
              Text(controller.posts[index].comments.length.toString()),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Iconsax.share))
            ],
          )
        ],
      ),
    );
  }
}
