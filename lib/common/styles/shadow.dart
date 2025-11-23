import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/colors.dart';

class AppShadow{
  static final verticalproductshadow=BoxShadow(
    color: AppColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );
  static final horizontalproductshadow=BoxShadow(
    color: AppColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0,2)
);
}