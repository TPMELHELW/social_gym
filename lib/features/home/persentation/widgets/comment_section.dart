import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:iconsax/iconsax.dart';

onCommentPress(BuildContext context, HomeController controller) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                // const Expanded(
                //   child: CustomTextFormField(
                //       hintText: 'Comment....',
                //       prefixIcon: Icon(Iconsax.message)),
                // ),
                IconButton(onPressed: () {}, icon: const Icon(Iconsax.send1))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
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
                            const Text('Mahmoud Elhelw')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('The Comment is Here'),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Iconsax.heart)),
                            const Text('100'),
                            IconButton(
                                onPressed: () {
                                  controller.showComment =
                                      !controller.showComment;
                                  controller.toggleComment(index);
                                  controller.update();
                                },
                                icon: const Icon(Iconsax.message)),
                            const Text('100'),
                          ],
                        ),
                        const Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                        GetBuilder<HomeController>(builder: (controlller) {
                          return controller.activeCommentIndex != index
                              ? GestureDetector(
                                  onTap: () {
                                    controller.showComment = false;
                                    controller.toggleComment(index);
                                    controller.update();
                                  },
                                  child: Row(
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
                        GetBuilder<HomeController>(builder: (controller) {
                          return controller.activeCommentIndex == index
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .tertiary,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const Text('Mahmoud Elhelw')
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text('The Comment is Here'),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(FluentIcons
                                                          .heart_32_regular)),
                                                  const Text('100'),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(FluentIcons
                                                          .comment_12_regular)),
                                                  const Text('100'),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : const SizedBox();
                        })
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}
