import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/constants/app_assets.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/core/utils/enum_utils.dart';
import 'package:my_profile/core/utils/shared_preferences_utils.dart';
import 'package:my_profile/core/utils/validation_utils.dart';
import 'package:my_profile/di/injector.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';
import 'package:my_profile/features/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:my_profile/features/presentation/widget/app_button.dart';
import 'package:my_profile/features/presentation/widget/app_card.dart';
import 'package:my_profile/features/presentation/widget/app_text_field.dart';
import 'package:my_profile/features/presentation/widget/common_widgets.dart';
import 'package:my_profile/features/presentation/widget/dialog_box.dart';

import '../widget/add_skill_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  final EditFields editFields;
  const EditProfileScreen({super.key, required this.editFields});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController controller = TextEditingController();
  final SharedPrefUtils prefUtils = sl<SharedPrefUtils>();
  final EditProfileBloc bloc = sl<EditProfileBloc>();
  final List<String> skills = [];
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller.text = switch (widget.editFields) {
      EditFields.name => prefUtils.userDetails?.name ?? "",
      EditFields.emailId => prefUtils.userDetails?.emailId ?? "",
      _ => "",
    };
    if (widget.editFields == EditFields.skills) {
      skills.addAll(prefUtils.userDetails?.skills ?? []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressedHandle,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            switch (widget.editFields) {
              EditFields.name => AppStrings.name,
              EditFields.emailId => AppStrings.emailId,
              EditFields.skills => AppStrings.skills,
              EditFields.workExperience => AppStrings.workExperience
            },
          ),
          leading: IconButton(
            onPressed: () async {
              bool shouldPop = await _onBackPressedHandle();
              if (shouldPop && mounted) {
                context.pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: Dimens.padding16.allPadding,
          child: CustomCard(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: BlocListener(
                bloc: bloc,
                listener: (context, state) {
                  if (state is UpdateDetailsSuccess) {
                    context.pop();
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Dimens.padding4.verticalSpace,
                    if (widget.editFields == EditFields.name ||
                        (widget.editFields == EditFields.emailId))
                      ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, value, child) {
                            return AppTextField(
                              prefixIcon: switch (widget.editFields) {
                                EditFields.emailId => AppAssets.mailSvg,
                                EditFields.name => AppAssets.profileSvg,
                                _ => ""
                              },
                              controller: controller,
                              hint: switch (widget.editFields) {
                                EditFields.name => AppStrings.enterName,
                                EditFields.emailId => AppStrings.enterEmailId,
                                _ => ""
                              },
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _onSubmit(),
                              validator: (value) =>
                                  widget.editFields == EditFields.emailId
                                      ? CustomValidation.validateEmail(value)
                                      : CustomValidation.validateNonEmpty(
                                          AppStrings.name, value),
                            );
                          }),
                    if (widget.editFields == EditFields.skills)
                      BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 8,
                              children: [
                                ...skills.map((e) => RawChip(
                                      label: Text(e),
                                      selected: false,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      side: BorderSide.none,
                                      deleteIcon: const Icon(
                                        Icons.clear,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      onDeleted: () {
                                        skills.remove(e);
                                        bloc.add(UpdateSkillsEvent());
                                      },
                                      backgroundColor: context.themeColor,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    )),
                                RawChip(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AddSkillsDialog(
                                              onValueChange: (value) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (!skills.contains(value)) {
                                                  skills.add(value);
                                                  bloc.add(UpdateSkillsEvent());
                                                  context.pop();
                                                } else {
                                                  showErrorSnackBar(
                                                      errorMsg:
                                                          AppStrings.sameSkills,
                                                      context: context);
                                                }
                                              },
                                            ));
                                  },
                                  label: const Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  selected: false,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                )
                              ],
                            ),
                          );
                        },
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
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (widget.editFields == EditFields.skills) {
      prefUtils.userDetails?.skills?.clear();
      prefUtils.userDetails?.skills?.addAll(skills);
    }
    if (widget.editFields != EditFields.skills) {
      if (formKey.currentState?.validate() == true) {
        bloc.add(EditProfile(widget.editFields,
            value: controller.text, skills: skills));
      }
    } else {
      bloc.add(EditProfile(widget.editFields,
          value: controller.text, skills: skills));
    }
  }

  Future<bool> _onBackPressedHandle() async {
    bool shouldPop = false;

    if (widget.editFields == EditFields.skills) {
      if (listEquals(prefUtils.userDetails?.skills, skills)) {
        shouldPop = true;
      } else {
        shouldPop = false;
      }
    } else if (widget.editFields == EditFields.emailId) {
      if (prefUtils.userDetails?.emailId == controller.text) {
        shouldPop = true;
      } else {
        shouldPop = false;
      }
    } else if (widget.editFields == EditFields.name) {
      if (prefUtils.userDetails?.name == controller.text) {
        shouldPop = true;
      } else {
        shouldPop = false;
      }
    }

    if (shouldPop) {
      return true;
    } else {
      await showDialog(
          context: context,
          builder: (context) => ConfirmOnPopDialog(
                title: AppStrings.alert,
                subtitle: AppStrings.areYouSureYouWantToLeavePage,
                positiveText: AppStrings.yes,
                negativeText: AppStrings.no,
                onPositiveTap: () {
                  shouldPop = true;
                  context.pop();
                },
                onNegativeTap: () {
                  shouldPop = false;
                  context.pop();
                },
              ));
    }

    return shouldPop;
  }
}
