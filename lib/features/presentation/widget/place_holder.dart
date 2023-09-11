import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_profile/constants/app_assets.dart';
import 'package:my_profile/constants/app_color.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: Dimens.padding16.allPadding,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor,
            border: Border.all(color: context.themeDarkColor, width: 2)),
        child: SvgPicture.asset(AppAssets.profileSvg,
            height: Dimens.mediumIconSize,
            width: Dimens.mediumIconSize,
            theme: SvgTheme(currentColor: context.themeDarkColor)));
  }
}
