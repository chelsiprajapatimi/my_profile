import 'package:flutter/material.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';

class AppCheckBox extends StatelessWidget {
  final bool needToRemember;
  final String title;
  final ValueChanged<bool> onChange;

  const AppCheckBox(
      {super.key,
      required this.needToRemember,
      required this.title,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onChange(!needToRemember);
      },
      child: Row(
        children: [
          SizedBox(
            height: 16,
            width: 16,
            child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: context.themeDarkColor,
                side: BorderSide(color: context.themeDarkColor),
                value: needToRemember,
                onChanged: (value) {
                  onChange(!needToRemember);
                }),
          ),
          Dimens.padding8.horizontalSpace,
          Text(
            title,
            style: context.textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
