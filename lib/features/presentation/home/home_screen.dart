import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/constants/app_color.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/core/utils/enum_utils.dart';
import 'package:my_profile/core/utils/shared_preferences_utils.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';
import 'package:my_profile/features/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:my_profile/features/presentation/widget/app_card.dart';
import 'package:my_profile/features/presentation/widget/dialog_box.dart';
import 'package:my_profile/features/presentation/widget/edit_widget.dart';
import 'package:my_profile/router/routes.dart';

import '../../../constants/app_assets.dart';
import '../../../di/injector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SharedPrefUtils prefUtils = sl<SharedPrefUtils>();
  final EditProfileBloc bloc = sl<EditProfileBloc>();
  Uint8List? imageValue;

  @override
  void initState() {
    super.initState();
    if (prefUtils.userDetails?.userImage != null) {
      imageValue = base64Decode(prefUtils.userDetails!.userImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  bloc.add(LogoutEvent());
                },
                child: Padding(
                  padding: Dimens.padding8.allPadding,
                  child: Icon(
                    Icons.login_outlined,
                    color: context.themeDarkColor,
                  ),
                )),
          )
        ],
      ),
      body: BlocConsumer(
        bloc: bloc,
        buildWhen: (context, state) =>
            state is UpdateDetailsSuccess ||
            state is ImageSuccessState ||
            state is DeletedSuccessfulState,
        listener: (context, state) {
          if (state is ImageSuccessState) {
            imageValue = state.selectedImage;
          } else if (state is ImageErrorState) {
            showDialog(
                context: context,
                builder: (context) => ConfirmOnPopDialog(
                      title: AppStrings.alert,
                      subtitle: AppStrings.permissionIsNotGranted,
                      positiveText: AppStrings.okay,
                      onPositiveTap: () {
                        context.pop();
                      },
                    ));
          } else if (state is LogoutState) {
            showDialog(
                context: context,
                builder: (context) => ConfirmOnPopDialog(
                      title: AppStrings.alert,
                      subtitle: AppStrings.areYouSureYouWantToLogout,
                      positiveText: AppStrings.yes,
                      negativeText: AppStrings.no,
                      onPositiveTap: () {
                        context.go(Routes.loginScreen);
                      },
                      onNegativeTap: () {
                        context.pop();
                      },
                    ));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: Dimens.padding16.topPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: Dimens.largeIconSize,
                    width: Dimens.largeIconSize,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: Container(
                                height: Dimens.largeIconSize,
                                width: Dimens.largeIconSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.whiteColor,
                                  border:
                                      Border.all(color: context.themeDarkColor),
                                ),
                                child: imageValue != null
                                    ? ClipOval(
                                        child: Image.memory(
                                        imageValue!,
                                        fit: BoxFit.fill,
                                      ))
                                    : Padding(
                                        padding: Dimens.padding24.allPadding,
                                        child: SvgPicture.asset(
                                          AppAssets.profileSvg,
                                        ),
                                      )),
                          ),
                        ),
                        Positioned(
                            bottom: 6,
                            right: 6,
                            child: InkWell(
                              onTap: () {
                                bloc.add(PickImageEvent());
                              },
                              child: Container(
                                  padding: Dimens.padding4.allPadding,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whiteColor,
                                      border: Border.all(
                                          color: context.themeColor)),
                                  child: SvgPicture.asset(
                                    AppAssets.cameraSvg,
                                    height: 18,
                                    width: 18,
                                  )),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: Dimens.padding16.lrtPadding,
                    child: CustomCard(
                      padding: Dimens.padding16.verticalPadding,
                      child: EditWidget(
                        title: AppStrings.emailId,
                        value: "${prefUtils.userDetails?.emailId}",
                        editFields: EditFields.emailId,
                        onTap: () {
                          context.push(Routes.editProfileScreen,
                              extra: EditFields.emailId);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: Dimens.padding16.lrtPadding,
                    child: CustomCard(
                      padding: Dimens.padding16.verticalPadding,
                      child: EditWidget(
                        title: AppStrings.name,
                        value: "${prefUtils.userDetails?.name}",
                        editFields: EditFields.name,
                        onTap: () {
                          context.push(Routes.editProfileScreen,
                              extra: EditFields.name);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: Dimens.padding16.lrtPadding,
                    child: CustomCard(
                      padding: Dimens.padding16.verticalPadding,
                      child: EditWidget(
                        title: AppStrings.skills,
                        skills: prefUtils.userDetails?.skills,
                        editFields: EditFields.skills,
                        onTap: () {
                          context.push(Routes.editProfileScreen,
                              extra: EditFields.skills);
                        },
                      ),
                    ),
                  ),
                  SafeArea(
                    maintainBottomViewPadding: true,
                    child: Container(
                      margin: Dimens.padding16.allPadding,
                      child: CustomCard(
                        padding: Dimens.padding16.verticalPadding,
                        child: EditWidget(
                          title: AppStrings.workExperience,
                          workExperience: prefUtils.userDetails?.workExperience,
                          editFields: EditFields.workExperience,
                          workExperienceCallback: (index) {
                            if (index != null) {
                              context.push(Routes.editWorkExperience,
                                  extra: prefUtils
                                      .userDetails?.workExperience?[index]);
                            } else {
                              context.push(Routes.editWorkExperience);
                            }
                          },
                          delete: (index) {
                            showDialog(
                                context: context,
                                builder: (context) => ConfirmOnPopDialog(
                                      title: AppStrings.alert,
                                      subtitle:
                                          AppStrings.areYouSureYouWantToDelete,
                                      positiveText: AppStrings.yes,
                                      negativeText: AppStrings.no,
                                      onPositiveTap: () {
                                        if (index != null) {
                                          context.pop();
                                          bloc.add(
                                              DeleteWorkExperienceEvent(index));
                                        }
                                      },
                                      onNegativeTap: () {
                                        context.pop();
                                      },
                                    ));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
