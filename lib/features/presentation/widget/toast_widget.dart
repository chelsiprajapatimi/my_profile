import 'package:flutter/material.dart';
import 'package:my_profile/constants/app_color.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/dimens.dart';
import 'package:my_profile/extensions/context_extension.dart';
import 'package:my_profile/extensions/double_extensions.dart';

class ToastWidget extends StatefulWidget {
  final String toastMessage;
  final VoidCallback? onClose;

  const ToastWidget({Key? key, this.toastMessage = "", this.onClose})
      : super(key: key);

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.whiteColor,
      elevation: 5,
      shadowColor: Colors.black87,
      child: Container(
        padding: Dimens.padding12.horizontalPadding,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Padding(
          padding: Dimens.padding8.verticalPadding,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  //height: Dimens.d48,
                  width: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: AppColors.warningRedColor,
                  ),
                ),
                Dimens.padding12.horizontalSpace,
                Expanded(
                  child: Padding(
                    padding: Dimens.padding4.verticalPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Spacer(),
                        Text(
                          AppStrings.error,
                          style: context.textTheme.displaySmall
                              ?.copyWith(color: AppColors.warningRedColor),
                        ),
                        Dimens.padding4.verticalSpace,
                        Text(
                          widget.toastMessage,
                          style: context.textTheme.displaySmall,
                        ),
                        //const Spacer(),
                      ],
                    ),
                  ),
                ),
                Dimens.padding12.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    widget.onClose?.call();
                  },
                  child: const Icon(Icons.close_rounded),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
