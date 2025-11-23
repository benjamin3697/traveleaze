import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/features/authentication/controllers/auth_repository.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/image_strings.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';
import 'package:traveleaze/utilities/device/device_utility.dart'; // 1. Import device utility

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthRepository>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // 2. Use a SizedBox to constrain the Column to the screen height
          child: SizedBox(
            height: AppDeviceUtility.getScreenHeight(context) - (kToolbarHeight), // Adjust for app bar/safe area
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultSpace, // Use consistent padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center, // This will now work correctly
                children: [
                  // --- Removed the top SizedBox to allow for true centering ---

                  // --- Your content ---
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems), // Adjusted spacing
                  const Text(
                    'Please sign in to continue with Google!',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: AppSizes.fontSizeMd,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections), // Adjusted spacing

                  // --- Google Button ---
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                          () => OutlinedButton.icon(
                        icon: authController.isLoading.value
                            ? const SizedBox.shrink()
                            : Image.asset(
                          AppImages.googleLogo,
                          width: AppSizes.iconMd,
                        ),
                        label: authController.isLoading.value
                            ? const CircularProgressIndicator(color: AppColors.primary)
                            : const Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: AppSizes.fontSizeMd,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: AppSizes.md), // Use consistent padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                          ),
                          side: const BorderSide(color: AppColors.grey),
                        ),
                        onPressed: authController.isLoading.value
                            ? null
                            : () => authController.signInWithGoogle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
