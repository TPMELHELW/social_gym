import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/core/constants/app_enum.dart';
import 'package:gym_app/core/validation/validation.dart';
import 'package:gym_app/features/share_post/controller/share_post_controller.dart';
import 'package:iconsax/iconsax.dart';

class SharePostScreen extends StatelessWidget {
  final bool isEdit;
  const SharePostScreen({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<SharePostController>(
              init: Get.put(SharePostController()),
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          Form(
                            key: controller.formState,
                            child: Expanded(
                              child: CustomTextFormField(
                                validator: (value) =>
                                    AppFieldValidator.validateEmpty(
                                        value, 'Post'),
                                hintText: 'Post....',
                                prefixIcon: const Icon(Iconsax.paperclip),
                                controller: controller.postController,
                              ),
                            ),
                          ),
                          controller.statusRequest == StatusRequest.loading
                              ? const CircularProgressIndicator()
                              : IconButton(
                                  onPressed: () => isEdit
                                      ? controller.editPost()
                                      : controller.postFun(),
                                  icon: const Icon(Iconsax.send1))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => controller.uploadImage(),
                              icon: const Icon(Iconsax.image)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Iconsax.video))
                        ],
                      ),
                      controller.imageFile == null
                          ? const SizedBox()
                          : Image.file(
                              File(controller.imageFile!.path),
                              height: 200,
                            )
                    ],
                  ),
                );
              }),
        ],
      )),
    );
  }
}
