import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/core/utils/shared_preferences_utils.dart';
import 'package:my_profile/core/utils/validation_utils.dart';
import 'package:my_profile/di/injector.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';
import 'package:my_profile/features/presentation/login/bloc/login_bloc.dart';
import 'package:my_profile/features/presentation/login/bloc/login_event.dart';
import 'package:my_profile/features/presentation/login/bloc/login_state.dart';
import 'package:my_profile/features/presentation/widget/app_checkbox.dart';
import 'package:my_profile/features/presentation/widget/app_text_field.dart';
import 'package:my_profile/features/presentation/widget/common_widgets.dart';
import 'package:my_profile/features/presentation/widget/place_holder.dart';
import 'package:my_profile/router/routes.dart';

import '../../../constants/app_assets.dart';
import '../widget/app_button.dart';
import '../widget/app_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> needToRemember = ValueNotifier(false);
  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  final GlobalKey<FormState> formKey = GlobalKey();
  final LoginBloc bloc = sl<LoginBloc>();
  final SharedPrefUtils sharedPrefUtils = sl<SharedPrefUtils>();
  final ValueNotifier<bool> isAutoValidate = ValueNotifier(false);

  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();

  @override
  void initState() {
    super.initState();
    if (sharedPrefUtils.userDetails?.needToRemember ?? false) {
      emailIdController.text = sharedPrefUtils.userDetails?.emailId ?? "";
      passwordController.text = sharedPrefUtils.userDetails?.password ?? "";
      needToRemember.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: Dimens.padding16.allPadding,
        alignment: Alignment.center,
        child: BlocListener<LoginBloc, LoginState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is LoginError) {
              showErrorSnackBar(errorMsg: state.errorMessage, context: context);
            } else if (state is LoginSuccess) {
              context.go(Routes.homeScreen);
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: CustomCard(
                  padding: Dimens.padding24.allPadding,
                  child: ValueListenableBuilder(
                      valueListenable: isAutoValidate,
                      builder: (context, value, child) {
                        return Form(
                          autovalidateMode: isAutoValidate.value
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Dimens.padding24.verticalSpace,
                              Text(
                                AppStrings.emailId,
                                style: context.textTheme.headlineSmall,
                              ),
                              Dimens.padding8.verticalSpace,
                              AppTextField(
                                focusNode: focusEmail,
                                validator: CustomValidation.validateEmail,
                                controller: emailIdController,
                                hint: AppStrings.enterEmailId,
                                prefixIcon: AppAssets.mailSvg,
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (value) {
                                  if (FocusScope.of(context).canRequestFocus) {
                                    FocusScope.of(context).requestFocus(
                                      focusPassword,
                                    );
                                  }
                                },
                              ),
                              Dimens.padding16.verticalSpace,
                              Text(
                                AppStrings.password,
                                style: context.textTheme.headlineSmall,
                              ),
                              Dimens.padding8.verticalSpace,
                              ValueListenableBuilder(
                                  valueListenable: passwordVisible,
                                  builder: (context, value, child) {
                                    return AppTextField(
                                      focusNode: focusPassword,
                                      validator: CustomValidation
                                          .validatePasswordEmpty,
                                      controller: passwordController,
                                      hint: AppStrings.enterPassword,
                                      obscureText: !passwordVisible.value,
                                      prefixIcon: AppAssets.passwordSvg,
                                      onSuffixTap: () {
                                        passwordVisible.value =
                                            !passwordVisible.value;
                                      },
                                      suffixIcon: value
                                          ? AppAssets.hideSvg
                                          : AppAssets.viewSvg,
                                      onFieldSubmitted: (value) => onSubmit(),
                                    );
                                  }),
                              Dimens.padding16.verticalSpace,
                              ValueListenableBuilder(
                                  valueListenable: needToRemember,
                                  builder: (context, value, child) {
                                    return AppCheckBox(
                                      needToRemember: needToRemember.value,
                                      title: AppStrings.rememberMe,
                                      onChange: (value) {
                                        needToRemember.value = value;
                                      },
                                    );
                                  }),
                              Dimens.padding16.verticalSpace,
                              AppButton(
                                text: AppStrings.login,
                                onTap: onSubmit,
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
              const Positioned(
                right: 0,
                left: 0,
                child: Hero(
                  tag: 'profile_image',
                  child: PlaceHolderWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    FocusScope.of(context).unfocus();
    if (formKey.currentState?.validate() == true) {
      bloc.add(DoLoginEvent(emailIdController.text, passwordController.text,
          needToRemember.value));
    } else {
      isAutoValidate.value = true;
    }
  }
}
