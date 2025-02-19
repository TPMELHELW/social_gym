import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/model/comment_model.dart';
import 'package:gym_app/features/home/persentation/widgets/comment_field_widget.dart';
import 'package:gym_app/features/home/persentation/widgets/comments_of_the_comment_widget.dart';
import 'package:iconsax/iconsax.dart';

onCommentPress(BuildContext context, HomeController controller, int postIndex) {
  final comments = controller.posts[postIndex].comments;
  Get.bottomSheet(
    GetBuilder<HomeController>(
        init: HomeController.instance,
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommentFieldWidget(
                  index: postIndex,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final cc = comments[index] as CommentModel;
                        final like = cc.likes.contains(controller.currentUser);
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(cc.fullName)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(cc.commentText),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () => controller.likeFun(
                                          postIndex, index, null),
                                      icon: Icon(like
                                          ? CupertinoIcons.heart_fill
                                          : Iconsax.heart)),
                                  Text(cc.likes.length.toString()),
                                  IconButton(
                                      onPressed: () {
                                        // controller.currentComment = controller
                                        //     .posts[postIndex].comments[index];
                                        // controller.commentController.text =
                                        //     controller.currentComment.fullName;

                                        controller.showComment =
                                            !controller.showComment;
                                        controller.toggleComment(index);
                                        controller.update();
                                      },
                                      icon: const Icon(Iconsax.message)),
                                  Text(cc.comments.length.toString()),
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: Colors.white,
                              ),
                              GetBuilder<HomeController>(
                                  builder: (controlller) {
                                return controller.activeCommentIndex != index
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.showComment = false;
                                          controller.toggleComment(index);
                                          controller.update();
                                        },
                                        child: const Row(
                                          children: [
                                            CircleAvatar(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Ahmed Elhelw',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('this is a comment reply....'),
                                          ],
                                        ),
                                      )
                                    : const SizedBox();
                              }),
                              CommentsOfTheCommentWidget(
                                mainIndex: postIndex,
                                secondaryIndex: index,
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        }),
  );
}
