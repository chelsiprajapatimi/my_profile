import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_profile/constants/app_assets.dart';
import 'package:my_profile/constants/app_color.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/core/utils/enum_utils.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';
import 'package:my_profile/features/models/user_details_model.dart';

typedef WorkExperienceCallback = void Function(int?);

class EditWidget extends StatelessWidget {
  final EditFields editFields;
  final String title;
  final String? value;
  final List<String>? skills;
  final List<WorkExperienceData>? workExperience;
  final VoidCallback? onTap;
  final WorkExperienceCallback? workExperienceCallback;
  final WorkExperienceCallback? delete;
  const EditWidget(
      {super.key,
      required this.title,
      this.value,
      this.skills,
      this.workExperience,
      this.onTap,
      required this.editFields,
      this.workExperienceCallback,
      this.delete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimens.padding16.horizontalPadding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.headlineMedium,
                    ),
                    InkWell(
                        onTap: () {
                          if (editFields == EditFields.workExperience) {
                            workExperienceCallback?.call(null);
                          } else {
                            if (onTap != null) {
                              onTap!();
                            }
                          }
                        },
                        child: editFields != EditFields.workExperience
                            ? SvgPicture.asset(
                                AppAssets.editingSvg,
                                height: 18,
                                width: 18,
                              )
                            : SvgPicture.asset(
                                AppAssets.addSvg,
                                height: 18,
                                width: 18,
                              ))
                  ],
                ),
                Dimens.padding4.verticalSpace,
                if (editFields == EditFields.name ||
                    editFields == EditFields.emailId)
                  Text(
                    value ?? "",
                    style: context.textTheme.displayMedium,
                  ),
                if (editFields == EditFields.skills)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 8,
                      children: [
                        ...(skills ?? []).map((e) => RawChip(
                              label: Text(e),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide.none),
                              selected: false,
                              deleteIcon: const Icon(
                                Icons.clear,
                                size: 20,
                                color: Colors.white,
                              ),
                              backgroundColor: context.themeColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              side: BorderSide.none,
                            )),
                      ],
                    ),
                  ),
                if (editFields == EditFields.workExperience)
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: workExperience?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: Dimens.padding8.verticalPadding,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleDescriptionRow(
                                    title: AppStrings.companyName,
                                    content:
                                        "${workExperience?[index].companyName}",
                                  ),
                                  TitleDescriptionRow(
                                    title: AppStrings.designation,
                                    content:
                                        "${workExperience?[index].designation}",
                                  ),
                                  TitleDescriptionRow(
                                    title: AppStrings.experience,
                                    content:
                                        "${workExperience?[index].experience} Years"
                                        "",
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    workExperienceCallback?.call(index);
                                  },
                                  child: SvgPicture.asset(
                                    AppAssets.editingSvg,
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Dimens.padding8.verticalSpace,
                                InkWell(
                                  onTap: () {
                                    delete?.call(index);
                                  },
                                  child: SvgPicture.asset(
                                    AppAssets.deleteSvg,
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.borderColor,
                      height: 1,
                      thickness: 0.2,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleDescriptionRow extends StatelessWidget {
  final String title;
  final String content;
  const TitleDescriptionRow(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:  ", style: context.textTheme.headlineSmall),
        Text(content, style: context.textTheme.displaySmall),
      ],
    );
  }
}
