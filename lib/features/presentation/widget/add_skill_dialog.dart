import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/constants/app_assets.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/core/utils/validation_utils.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';
import 'package:my_profile/features/presentation/widget/app_button.dart';
import 'package:my_profile/features/presentation/widget/app_text_field.dart';

class AddSkillsDialog extends StatefulWidget {
  final ValueChanged onValueChange;

  const AddSkillsDialog({super.key, required this.onValueChange});

  @override
  State<AddSkillsDialog> createState() => _AddSkillsDialogState();
}

class _AddSkillsDialogState extends State<AddSkillsDialog> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: Dimens.padding24.allPadding,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.addSkill,
                    style: context.textTheme.headlineMedium,
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ))
                ],
              ),
              Dimens.padding16.verticalSpace,
              AppTextField(
                prefixIcon: AppAssets.skillsSvg,
                controller: controller,
                hint: AppStrings.technologies,
                textInputAction: TextInputAction.done,
                validator: (value) =>
                    CustomValidation.validateNonEmpty(AppStrings.skill, value),
                onFieldSubmitted: (_) => _onSubmit(),
              ),
              Dimens.padding16.verticalSpace,
              AppButton(
                text: AppStrings.save,
                onTap: _onSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      widget.onValueChange(controller.text);
    }
  }
}
