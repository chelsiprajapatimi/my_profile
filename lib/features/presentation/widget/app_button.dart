import 'package:flutter/material.dart';
import 'package:my_profile/constants/app_color.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const AppButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(color: AppColors.whiteColor),
          )),
    );
  }
}
