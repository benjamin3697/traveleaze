import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';
import 'package:traveleaze/utilities/device/device_utility.dart';
import 'package:traveleaze/utilities/helpers/helper_functions.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.hintText,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onChanged,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.defaultSpace,
    ),
  });

  final String hintText;
  final IconData? icon;
  final bool showBackground, showBorder;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Padding(
      padding: padding,
      child: Container(
        width: AppDeviceUtility.getScreenWidth(context),
        decoration: BoxDecoration(
          color: showBackground
              ? (dark ? AppColors.dark : AppColors.light)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: Colors.grey) : null,
        ),
        child: TextField(
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.darkerGrey),
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(AppSizes.md),
          ),
        ),
      ),
    );
  }
}
