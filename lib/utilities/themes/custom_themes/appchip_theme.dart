import 'package:flutter/material.dart';

class AppChipTheme{
  AppChipTheme._();

  /// Light Chip Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(
      color: Colors.black,),
      selectedColor: Colors.orange,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      checkmarkColor: Colors.white,
  );

  /// Dark Chip Theme
  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle:  TextStyle(
      color: Colors.white,),
      selectedColor: Colors.orange,
      padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      checkmarkColor: Colors.white,
);
}
