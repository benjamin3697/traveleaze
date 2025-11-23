// lib/screens/settings/profile.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:traveleaze/common/widgets/appbar/appbar.dart';
import 'package:traveleaze/common/widgets/text/section_heading.dart';
import 'package:traveleaze/features/authentication/controllers/update_profile_controller.dart';
import 'package:traveleaze/features/authentication/controllers/user_controller.dart';
import 'package:traveleaze/screens/settings/profile_menu.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final userController = UserController.instance;
    final updateController = Get.put(UpdateProfileController());

    return Scaffold(
      appBar: Appbar(
        showBackArrow: true,
        title: Text('Edit Profile'),
        // Add a "Save" button
        actions: [
          TextButton(
            onPressed: () => updateController.updateUserProfile(),
            child: const Text('Save', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // --- PROFILE PICTURE ---
              Center(
                child: Column(
                  children: [
                    // Use Obx to make the profile picture reactive
                    Obx(() {
                      final networkImage = userController.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? NetworkImage(networkImage) : null;
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: image,
                        child: image == null ? const Icon(Icons.person, size: 50) : null,
                      );
                    }),
                    TextButton(
                      onPressed: () => updateController.uploadProfilePicture(),
                      child: const Text('Change Profile Picture', style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // --- FORM FOR UPDATING PROFILE INFO ---
              const AppSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Form(
                key: updateController.updateProfileFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: updateController.displayName,
                      decoration: const InputDecoration(labelText: 'Display Name', prefixIcon: Icon(Iconsax.user)),
                      validator: (value) => value!.isEmpty ? 'Display Name cannot be empty' : null,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: updateController.phoneNumber,
                      decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Iconsax.call)),
                      validator: (value) => value!.isEmpty ? 'Phone Number cannot be empty' : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // --- PERSONAL INFO (Read-only) ---
              AppProfileMenu(title: 'User ID', value: userController.user.value.id, icon: Iconsax.copy, onPressed: () {
                // Implement copy to clipboard
                //TLoaders.successSnackBar(title: 'Copied', message: 'User ID copied to clipboard.');
              }),
              AppProfileMenu(title: 'E-mail', value: userController.user.value.email, onPressed: () {}),

              const Divider(),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Implement delete account dialog and logic
                  },
                  child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
