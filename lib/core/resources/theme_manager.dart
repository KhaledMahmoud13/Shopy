import 'package:flutter/material.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/font_manager.dart';
import 'package:shopy/core/resources/styles_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManager.secondary, fontSize: FontSize.s20),
      headlineLarge: getSemiBoldStyle(
          color: ColorManager.secondary, fontSize: FontSize.s28),
      headlineMedium:
          getMediumStyle(color: ColorManager.secondary, fontSize: FontSize.s20),
      bodyMedium: getSemiBoldStyle(
          color: ColorManager.secondary, fontSize: FontSize.s17),
      titleMedium:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s17),
      bodyLarge: getRegularStyle(color: ColorManager.grey),
      bodySmall: getRegularStyle(color: ColorManager.grey),
      labelSmall:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s16),
      displayMedium: getRegularStyle(color: ColorManager.secondary),
      displaySmall:
          getRegularStyle(color: ColorManager.red, fontSize: FontSize.s16),
      labelMedium:
          getMediumStyle(color: ColorManager.secondary, fontSize: FontSize.s16),
      labelLarge:
          getMediumStyle(color: ColorManager.secondary, fontSize: FontSize.s22),
      titleLarge:
          getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s17),
      headlineSmall: getRegularStyle(
          color: ColorManager.secondary, fontSize: FontSize.s18),
      titleSmall:
          getRegularStyle(color: ColorManager.red, fontSize: FontSize.s18),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppPadding.p8,
        horizontal: AppPadding.p16,
      ),
      fillColor: ColorManager.darkSlateGray,
      hintStyle: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s16,
      ),
      errorStyle: getRegularStyle(color: ColorManager.red),
      enabledBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.darkSlateGray, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorManager.background,
      headerBackgroundColor: ColorManager.primary,
      headerForegroundColor: ColorManager.secondary,
      yearStyle: getRegularStyle(
        color: ColorManager.secondary,
        fontSize: FontSize.s14,
      ),
      dayForegroundColor: MaterialStateProperty.all(ColorManager.secondary),
      dayStyle: getRegularStyle(
        color: ColorManager.secondary,
        fontSize: FontSize.s14,
      ),
      weekdayStyle: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: getRegularStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s16,
        ),
      ),
      todayForegroundColor: MaterialStateProperty.all(
        ColorManager.secondary,
      ),
      headerHelpStyle: getMediumStyle(color: ColorManager.grey),
    ),
    scaffoldBackgroundColor: ColorManager.background,
  );
}
