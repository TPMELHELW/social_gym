import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/data/post_repository.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/persentation/widgets/post_widget.dart';
import 'package:gym_app/features/share_post/presentation/share_post_screen.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return SafeArea(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Get.to(() => const SharePostScreen()),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Row(
                        children: [
                          Icon(Iconsax.paperclip),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Post.....')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<HomeController>(builder: (cotnroller) {
            return NotificationListener(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  // fetchMoreData();
                  PostRepository().fetchMoreData();
                  return true;
                }
                return false;
              },
              child: Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      return PostWidget(
                        index: index,
                      );
                    }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
