import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/core/utils/shared_preferences_utils.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';
import 'package:my_profile/features/presentation/widget/place_holder.dart';
import 'package:my_profile/router/routes.dart';

import '../../../di/injector.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final SharedPrefUtils sharedPrefUtils = sl<SharedPrefUtils>();
  @override
  void initState() {
    super.initState();
    sharedPrefUtils.getUserDetails().then((userDetails) async {
      if (userDetails == null) {
        await sharedPrefUtils.setUserDetails(
            userDetailsData: sharedPrefUtils.defaultUserData);
      }
      Future.delayed(const Duration(seconds: 2), () {
        if (sharedPrefUtils.userDetails?.isLoggedIn == true) {
          if (mounted) {
            context.go(Routes.homeScreen);
          }
        } else {
          if (mounted) {
            context.go(Routes.loginScreen);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero(
              tag: 'profile_image',
              child: PlaceHolderWidget(),
            ),
            Dimens.padding12.verticalSpace,
            Text(
              AppStrings.myProfile,
              style: context.textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
