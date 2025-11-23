import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/image_strings.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: AppSizes.spaceBtwItems,
        children: [
          _socialButton(AppImages.googleLogo, onPressed: () {}),
          _socialButton(AppImages.facebookLogo, onPressed: () {}),
        ],
      ),
    );
  }

  Widget _socialButton(String assetPath, {required VoidCallback onPressed}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: AppSizes.iconMd + 8,
          height: AppSizes.iconMd + 8,
          child: Image.asset(
            assetPath,
            width: AppSizes.iconMd,
            height: AppSizes.iconMd,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}