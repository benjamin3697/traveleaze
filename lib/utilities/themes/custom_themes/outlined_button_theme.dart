import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/colors.dart';

class AppOutlinedButtonTheme {
  AppOutlinedButtonTheme._();

  // Light theme for outlined buttons
  static OutlinedButtonThemeData lightOutlinedButtonTheme = OutlinedButtonThemeData(
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

  // Dark theme for outlined buttons
  static OutlinedButtonThemeData darkOutlinedButtonTheme = OutlinedButtonThemeData(
   style: ElevatedButton.styleFrom(
  elevation: 0,
   backgroundColor: Colors.orange, // Button background color
   foregroundColor: Colors.white,
   disabledBackgroundColor: Colors.orange, 
   disabledForegroundColor: Colors.grey,
   side: const BorderSide(color: Colors.orange),// Text color
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
   textStyle: const TextStyle( fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600), // Button border radius

   padding: const EdgeInsets.symmetric(vertical: 18.0), // Button padding
)
);
}

