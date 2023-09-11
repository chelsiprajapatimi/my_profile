import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/constants/app_assets.dart';
import 'package:my_profile/core/utils/enum_utils.dart';
import 'package:my_profile/di/injector.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';
import 'package:my_profile/features/models/user_details_model.dart';
import 'package:my_profile/features/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:my_profile/features/presentation/widget/app_button.dart';
import 'package:my_profile/features/presentation/widget/dialog_box.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/dimens.dart';
import '../../../core/utils/validation_utils.dart';
import '../widget/app_text_field.dart';

class EditWorkExperienceScreen extends StatefulWidget {
  final WorkExperienceData? workExperience;

  const EditWorkExperienceScreen({
    super.key,
    required this.workExperience,
  });

  @override
  State<EditWorkExperienceScreen> createState() =>
      _EditWorkExperienceScreenState();
}

class _EditWorkExperienceScreenState extends State<EditWorkExperienceScreen> {
  final TextEditingController _companyNameController = TextEditingController(),
      _experienceController = TextEditingController(),
      _designationController = TextEditingController();

  final FocusNode focusCompanyName = FocusNode();
  final FocusNode focusDesignation = FocusNode();
  final FocusNode focusExperience = FocusNode();

  final _formKey = GlobalKey<FormState>();
  EditProfileBloc bloc = sl<EditProfileBloc>();

  @override
  void initState() {
    if (widget.workExperience != null) {
      _companyNameController.text = widget.workExperience?.companyName ?? '';
      _experienceController.text =
          widget.workExperience?.experience?.toStringAsFixed(2) ?? '';
      _designationController.text = widget.workExperience?.designation ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressedHandle,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(AppStrings.workExperience),
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
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: BlocListener(
            bloc: bloc,
            listener: (context, state) {
              if (state is UpdateDetailsSuccess) {
                context.pop();
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.companyName,
                            style: context.textTheme.displaySmall,
                          ),
                          Dimens.padding8.verticalSpace,
                          AppTextField(
                            focusNode: focusCompanyName,
                            validator: (value) =>
                                CustomValidation.validateNonEmpty(
                                    AppStrings.companyName, value),
                            controller: _companyNameController,
                            hint: AppStrings.companyName,
                            prefixIcon: AppAssets.companySvg,
                            onFieldSubmitted: (value) {
                              if (FocusScope.of(context).canRequestFocus) {
                                FocusScope.of(context).requestFocus(
                                  focusDesignation,
                                );
                              }
                            },
                          ),
                          Dimens.padding16.verticalSpace,
                          Text(
                            AppStrings.designation,
                            style: context.textTheme.displaySmall,
                          ),
                          Dimens.padding8.verticalSpace,
                          AppTextField(
                            focusNode: focusDesignation,
                            validator: (value) =>
                                CustomValidation.validateNonEmpty(
                                    AppStrings.designation, value),
                            controller: _designationController,
                            hint: AppStrings.designation,
                            onFieldSubmitted: (value) {
                              if (FocusScope.of(context).canRequestFocus) {
                                FocusScope.of(context).requestFocus(
                                  focusExperience,
                                );
                              }
                            },
                            prefixIcon: AppAssets.designationSvg,
                          ),
                          Dimens.padding16.verticalSpace,
                          Text(
                            AppStrings.experienceInYears,
                            style: context.textTheme.displaySmall,
                          ),
                          Dimens.padding8.verticalSpace,
                          AppTextField(
                            focusNode: focusExperience,
                            validator: (value) =>
                                CustomValidation.validateZeroEmpty(
                                    AppStrings.experience, value),
                            controller: _experienceController,
                            hint: AppStrings.experience,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _onSubmit(),
                            prefixIcon: AppAssets.workExperienceSvg,
                          ),
                          Dimens.padding16.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20)
                        .copyWith(bottom: 20),
                    child: AppButton(
                      onTap: _onSubmit,
                      text: AppStrings.save,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      WorkExperienceData? workExperienceData;
      if (widget.workExperience != null) {
        widget.workExperience?.designation = _designationController.text;
        widget.workExperience?.experience =
            double.tryParse(_experienceController.text);
        widget.workExperience?.companyName = _companyNameController.text;
      } else {
        workExperienceData = WorkExperienceData(
            designation: _designationController.text,
            experience: double.tryParse(_experienceController.text),
            companyName: _companyNameController.text);
      }

      bloc.add(EditProfile(EditFields.workExperience,
          workExperience: workExperienceData));
    }
  }

  Future<bool> _onBackPressedHandle() async {
    bool shouldPop = false;

    if (widget.workExperience == null &&
        _designationController.text.isEmpty &&
        _experienceController.text.isEmpty &&
        _companyNameController.text.isEmpty) {
      shouldPop = true;
    } else if (widget.workExperience?.designation !=
            _designationController.text ||
        widget.workExperience?.experience !=
            double.tryParse(_experienceController.text) ||
        widget.workExperience?.companyName != _companyNameController.text) {
      shouldPop = false;
    } else {
      shouldPop = true;
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
