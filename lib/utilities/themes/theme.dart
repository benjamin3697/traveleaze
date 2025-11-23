import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/themes/custom_themes/appbar_theme.dart';
import 'package:traveleaze/utilities/themes/custom_themes/appchip_theme.dart';
import 'package:traveleaze/utilities/themes/custom_themes/apptext_themes.dart';
import 'package:traveleaze/utilities/themes/custom_themes/button__shirt_theme.dart';
import 'package:traveleaze/utilities/themes/custom_themes/checkbox_theme.dart';
import 'package:traveleaze/utilities/themes/custom_themes/eleveted_button.dart';
import 'package:traveleaze/utilities/themes/custom_themes/outlined_button_theme.dart';
import 'package:traveleaze/utilities/themes/custom_themes/text_field_theme.dart';

class AppTheme{
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme,
    appBarTheme: AppbarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    
   
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.orange,
    textTheme: AppTextTheme.darkTextTheme,
     scaffoldBackgroundColor: Colors.black,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme,
    appBarTheme: AppbarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,

);
}
