import 'package:flutter/material.dart';

class AppCheckboxTheme {
  AppCheckboxTheme._();

  /// Light Checkbox Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
   shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      ),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white; // Check color when selected
        }
        else{
          return Colors.black; // Check color when not selected
        } // Check color when not selected
      }
      ),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.orange; // Fill color when selected
        }
        return Colors.transparent; // Fill color when not selected
      }),
  );

  /// Dark Checkbox Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
   shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      ),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white; // Check color when selected
        }
        else{
          return Colors.black; // Check color when not selected
        } // Check color when not selected
      }
      ),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.orange; // Fill color when selected
        }
        return Colors.transparent; // Fill color when not selected
}),
);
}
