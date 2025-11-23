import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class AppRoundedContainer extends StatelessWidget {
  const AppRoundedContainer(Text text, {super.key, 
  this.width,
  this.height,
  this.radius=AppSizes.cardRadiusLg,
  this.child,
  this.showBorder=false,
  this.backgroundColor=AppColors.grey,
  this.borderColor=Colors.grey,
  this.padding,
  this.margin,
  });
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:padding,
      margin:margin,
      width:width,
      height:height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder? Border.all(color: borderColor):null
      ),
      child: child,
);
}
}
