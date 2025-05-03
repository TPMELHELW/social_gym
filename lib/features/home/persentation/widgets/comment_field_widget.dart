import 'package:flutter/material.dart';
import 'package:gym_app/core/components/custom_text_form_field.dart';
import 'package:gym_app/core/validation/validation.dart';
import 'package:gym_app/features/home/controller/home_controller.dart';
import 'package:iconsax/iconsax.dart';

class CommentFieldWidget extends StatelessWidget {
  final int index;
  const CommentFieldWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController.instance;
    return Container(
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
          Form(
            key: controller.commentFormState,
            child: Expanded(
              child: CustomTextFormField(
                validator: (value) =>
                    AppFieldValidator.validateEmpty(value, 'Comment'),
                hintText: 'Comment....',
                prefixIcon: const Icon(Iconsax.message),
                controller: controller.commentController,
              ),
            ),
          ),
          IconButton(
              onPressed: () => controller.addComment(index, null),
              icon: const Icon(Iconsax.send1))
        ],
      ),
    );
  }
}
