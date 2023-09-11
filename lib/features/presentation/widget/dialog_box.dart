import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';

class ConfirmOnPopDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String positiveText;
  final String? negativeText;
  final VoidCallback? onPositiveTap;
  final VoidCallback? onNegativeTap;

  const ConfirmOnPopDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.positiveText,
      this.negativeText,
      this.onPositiveTap,
      this.onNegativeTap});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            actionsPadding: Dimens.padding8.allPadding,
            contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            title: Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            content: Text(
              subtitle,
              style: context.textTheme.displayMedium,
            ),
            actions: [
              if (negativeText != null)
                TextButton(
                  onPressed: onNegativeTap,
                  child: Text(
                    negativeText!.toUpperCase(),
                  ),
                ),
              TextButton(
                onPressed: onPositiveTap,
                child: Text(
                  positiveText.toUpperCase(),
                ),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            actions: [
              if (negativeText != null)
                TextButton(
                  onPressed: onNegativeTap,
                  child: Text(
                    negativeText!.toUpperCase(),
                  ),
                ),
              TextButton(
                onPressed: onPositiveTap,
                child: Text(
                  positiveText.toUpperCase(),
                ),
              ),
            ],
            content: Text(
              subtitle,
              style: context.textTheme.displayMedium,
            ),
          );
  }
}
