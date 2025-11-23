import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/utilities/constants/colors.dart';

/// A utility class for managing a full-screen loading dialog.
class TFullScreenLoader {
  /// Opens a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for dialogs
      barrierDismissible: false, // The user can't dismiss the dialog by tapping outside
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150, // Adjust size as needed
                child: Image.asset(animation), // Your loading animation or logo
              ),
              const SizedBox(height: 24),
              Text(
                text,
                style: Theme.of(Get.context!).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Stops the currently open loading dialog.
  /// This method finds the first active dialog and closes it.
  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the Navigator
  }
}


/// A utility class for showing different types of SnackBars.
class TLoaders {
  static void successSnackBar({required String title, String message = '', int duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: AppColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check, color: AppColors.white),
    );
  }

  static void warningSnackBar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.warning, color: AppColors.white),
    );
  }

  static void errorSnackBar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.close, color: AppColors.white),
    );
  }
}
