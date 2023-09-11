import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/constants/app_color.dart';
import 'package:my_profile/features/presentation/widget/toast_widget.dart';

void showErrorSnackBar(
    {required String errorMsg, required BuildContext context}) {
  bool isDialogVisible = true;
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.blackColor.withOpacity(0.4),
      builder: (context) => Wrap(children: [
            GestureDetector(
              onVerticalDragUpdate: (details) {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ToastWidget(
                  onClose: () {
                    Navigator.pop(context);
                  },
                  toastMessage: errorMsg,
                ),
              ),
            ),
          ])).then((value) => isDialogVisible = false);
  Future.delayed(const Duration(seconds: 3), () {
    if (isDialogVisible) {
      context.pop();
    }
  });
}
