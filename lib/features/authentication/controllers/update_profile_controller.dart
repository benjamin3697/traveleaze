// lib/features/authentication/controllers/update_profile_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveleaze/features/authentication/controllers/user_controller.dart';
import 'package:traveleaze/features/authentication/data/user_repository.dart';

// --- FIX: Add this import statement ---
import 'package:traveleaze/common/widgets/loaders/loaders.dart';
// ------------------------------------

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  // Text editing controllers for the form fields
  final displayName = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = TextEditingController();
  final dateOfBirth = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.find<UserRepository>();
  GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();

  /// Initialize with data from the main UserController
  @override
  void onInit() {
    super.onInit();
    initializeFields();
  }

  /// Populate the text fields with the current user's data
  void initializeFields() {
    displayName.text = userController.user.value.displayName;
    phoneNumber.text = userController.user.value.phoneNumber;
    // For other fields like gender and dateOfBirth, you'd add them to your UserModel first
    // gender.text = userController.user.value.gender;
    // dateOfBirth.text = userController.user.value.dateOfBirth;
  }

  /// Save the updated user data
  Future<void> updateUserProfile() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog('Updating your profile...', 'assets/images/logo.png');

      // Form validation
      if (!updateProfileFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Create a map of the data to be updated
      Map<String, dynamic> updatedData = {
        'DisplayName': displayName.text.trim(),
        'PhoneNumber': phoneNumber.text.trim(),
        // Add other fields here once they are in your UserModel
        // 'Gender': gender.text.trim(),
        // 'DateOfBirth': dateOfBirth.text.trim(),
      };

      // Call the repository to update the data
      await userRepository.updateUserDetails(userController.user.value.id, updatedData);

      // Update the reactive user model in the UserController
      userController.user.value.displayName = displayName.text.trim();
      userController.user.value.phoneNumber = phoneNumber.text.trim();
      // This forces the UI to refresh with the new values immediately.
      userController.user.refresh();

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message and navigate back
      TLoaders.successSnackBar(title: 'Success', message: 'Your profile has been updated.');
      Get.back(); // Go back to the previous screen
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Pick and upload profile image
  Future<void> uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        TFullScreenLoader.openLoadingDialog('Uploading image...', 'assets/images/logo.png');

        // Upload the image and get the URL
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update the user's profile picture URL in Firestore
        await userRepository.updateSingleField(userController.user.value.id, {'ProfilePicture': imageUrl});

        // Update the reactive user model
        userController.user.value.profilePicture = imageUrl;
        // This forces the UI to refresh with the new values immediately.
        userController.user.refresh();

        TFullScreenLoader.stopLoading();
        TLoaders.successSnackBar(title: 'Success', message: 'Your profile picture has been updated.');
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong: $e');
    }
  }
}
