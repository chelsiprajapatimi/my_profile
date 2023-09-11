import 'package:flutter/material.dart';
import 'package:my_profile/constants/app_color.dart';

class AppTheme {
  ThemeData get lightTheme {
    return ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: AppColors.bgColor,
        primaryColor: AppColors.themePrimaryColor,
        primaryColorDark: AppColors.themePrimaryDarkColor,
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: AppColors.headerColor,
                fontWeight: FontWeight.w500),
            iconTheme: IconThemeData(color: AppColors.headerColor)),
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: AppColors.hintColor),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.themePrimaryColor))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: TextStyle(color: AppColors.whiteColor),
          backgroundColor: AppColors.themePrimaryColor,
        )),
        checkboxTheme: CheckboxThemeData(
          overlayColor:
              MaterialStatePropertyAll(AppColors.themePrimaryDarkColor),
          checkColor: MaterialStatePropertyAll(AppColors.whiteColor),
        ),
        textTheme: TextTheme(
            displaySmall: TextStyle(fontSize: 14, color: AppColors.blackColor),
            displayMedium: TextStyle(fontSize: 16, color: AppColors.blackColor),
            displayLarge: TextStyle(fontSize: 24, color: AppColors.blackColor),
            headlineLarge: TextStyle(
                fontSize: 24,
                color: AppColors.headerColor,
                fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(
                fontSize: 18,
                color: AppColors.headerColor,
                fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(
                fontSize: 14,
                color: AppColors.headerColor,
                fontWeight: FontWeight.w500)));
  }
}
