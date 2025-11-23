import 'package:flutter/material.dart';

class AppBottomSheetTheme{
  AppBottomSheetTheme._();

  /// Light Bottom Sheet Theme
  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
   showDragHandle: true,
   backgroundColor: Colors.white,
   modalBackgroundColor: Colors.white,
   shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(16),
   ),
   constraints: const BoxConstraints(
     minWidth: double.infinity,
   ),
    
  );

  /// Dark Bottom Sheet Theme
  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
   showDragHandle: true,
   backgroundColor: Colors.black,
   modalBackgroundColor: Colors.black,
   shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(16),
   ),
   constraints: const BoxConstraints(
     minWidth: double.infinity,
),
);
}
