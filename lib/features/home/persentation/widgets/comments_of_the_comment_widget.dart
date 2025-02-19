import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/core/validation/validation.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:gym_app/features/home/model/comment_model.dart';
import 'package:iconsax/iconsax.dart';

class CommentsOfTheCommentWidget extends StatelessWidget {
  final int mainIndex, secondaryIndex;
  const CommentsOfTheCommentWidget(
      {super.key, required this.mainIndex, required this.secondaryIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return controller.activeCommentIndex == secondaryIndex
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                      ),
                      Form(
                        key: controller.secondCommentFormState,
                        child: Expanded(
                          child: CustomTextFormField(
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            validator: (value) =>
                                AppFieldValidator.validateEmpty(
                                    value, 'Comment'),
                            hintText: 'Comment....',
                            prefixIcon: const Icon(Iconsax.message),
                            controller: controller.secondCommentController,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () =>
                              controller.addComment(mainIndex, secondaryIndex),
                          icon: const Icon(Iconsax.send1))
                    ],
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.posts[mainIndex]
                        .comments[secondaryIndex].comments.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final coments = controller
                          .posts[mainIndex]
                          .comments[secondaryIndex]
                          .comments[index] as CommentModel;
                      bool like =
                          coments.likes.contains(controller.currentUser);
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(coments.fullName)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(coments.commentText),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () => controller.likeFun(
                                            mainIndex, secondaryIndex, index),
                                        icon: Icon(like
                                            ? CupertinoIcons.heart_fill
                                            : Iconsax.heart)),
                                    Text(coments.likes.length.toString()),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ],
            )
          : const SizedBox();
    });
  }
}
