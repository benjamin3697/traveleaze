import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
class AppElevatedButtonTheme{
AppElevatedButtonTheme._();

/// Light Elevated Button Theme
static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
 style: ElevatedButton.styleFrom(
  elevation: 0,
   backgroundColor: AppColors.primary, // Button background color
   foregroundColor: Colors.white,
   disabledBackgroundColor: Colors.grey, 
   disabledForegroundColor: Colors.grey,
   side: const BorderSide(color: AppColors.primary),// Text color
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
   textStyle: const TextStyle( fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600), // Button border radius

   padding: const EdgeInsets.symmetric(vertical: 18.0), // Button padding
  )
  );

/// Dark theme elevated button styles
  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
 style: ElevatedButton.styleFrom(
  elevation: 0,
   backgroundColor: AppColors.primary, // Button background color
   foregroundColor: Colors.white,
   disabledBackgroundColor: Colors.grey, 
   disabledForegroundColor: Colors.grey,
   side: const BorderSide(color: AppColors.primary),// Text color
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
   textStyle: const TextStyle( fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600), // Button border radius

   padding: const EdgeInsets.symmetric(vertical: 18.0), // Button padding
)
);
}
