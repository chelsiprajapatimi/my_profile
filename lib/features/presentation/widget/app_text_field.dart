import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_profile/constants/app_color.dart';
import 'package:my_profile/extensions/context_extension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isDense;
  final bool obscureText;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction textInputAction;
  final VoidCallback? onSuffixTap;
  final FocusNode? focusNode;
  const AppTextField(
      {super.key,
      required this.controller,
      required this.hint,
      this.isDense = true,
      this.validator,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.textInputAction = TextInputAction.next,
      this.onFieldSubmitted,
      this.keyboardType = TextInputType.text,
      this.onSuffixTap,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: context.textTheme.displaySmall,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.textTheme.displaySmall
            ?.copyWith(color: AppColors.borderColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        isDense: isDense,
        prefixIconConstraints: BoxConstraints.tight(const Size(32, 32)),
        suffixIconConstraints: BoxConstraints.tight(const Size(32, 32)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.themePrimaryDarkColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor)),
        prefixIcon: prefixIcon != null
            ? Center(
                child: SvgPicture.asset(
                  prefixIcon!,
                  height: 16,
                  width: 16,
                  theme: SvgTheme(currentColor: AppColors.headerColor),
                ),
              )
            : const SizedBox(),
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixTap,
                child: Center(
                  child: SvgPicture.asset(
                    suffixIcon!,
                    height: 16,
                    width: 16,
                    theme: SvgTheme(currentColor: AppColors.headerColor),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
