import 'package:flutter/widgets.dart';
import 'package:my_profile/constants/app_color.dart';
import 'package:my_profile/constants/dimens.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const CustomCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(Dimens.padding16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.cardShadow, spreadRadius: 0.8, blurRadius: 0.8)
          ]),
      child: child,
    );
  }
}
