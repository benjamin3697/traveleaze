// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/features/authentication/controllers/auth_repository.dart';
import 'package:traveleaze/features/authentication/controllers/user_controller.dart';
import 'package:traveleaze/screens/settings/profile.dart';
import 'package:traveleaze/screens/settings/settings.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: Using Get.find() is generally safer here if the controller is already initialized elsewhere.
    // However, Get.put() works if this is the first time it's being called.
    final controller = Get.put(UserController());

    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Obx(() {
            if (controller.profileLoading.value) {
              return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(),
                  ));
            }

            final user = controller.user.value;

            if (user.id.isEmpty) {
              return const Center(child: Text('User not found. Please re-login.'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48), // Spacer
                    Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.black54),
                      onPressed: () => Get.to(() => const SettingsScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // --- Profile Card ---
                Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.md),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                      border: Border.all(color: AppColors.grey.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: user.profilePicture.isNotEmpty ? NetworkImage(user.profilePicture) : null,
                          child: user.profilePicture.isEmpty ? const Icon(Icons.person, size: 40) : null,
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        Text(user.displayName, style: Theme.of(context).textTheme.headlineSmall),
                        Text('Student', style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: AppSizes.spaceBtwSections),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => Get.to(() => const Profile()),
                            child: const Text('Edit Profile'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // --- Account Information ---
                const Text('Account Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: AppSizes.spaceBtwItems),
                _infoCard(icon: Icons.email_outlined, title: 'Email Address', value: user.email),
                const SizedBox(height: AppSizes.spaceBtwItems),
                _infoCard(icon: Icons.phone, title: 'Phone Number', value: user.phoneNumber.isNotEmpty ? user.phoneNumber : 'Not provided'),
                const SizedBox(height: AppSizes.spaceBtwItems),
                _infoCard(icon: Icons.credit_card, title: 'University ID', value: user.universityId.isNotEmpty ? user.universityId : 'Not provided'),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // --- Sign Out Button ---
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    // --- MODIFICATION: Added Sign Out Dialog ---
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Sign Out",
                        middleText: "Are you sure you want to sign out?",
                        titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        // Confirmation Button
                        confirm: ElevatedButton(
                          onPressed: () {
                            // Close the dialog first
                            Get.back();
                            // Then call the sign out method
                            AuthRepository.instance.signOut();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, side: BorderSide.none),
                          child: const Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Text("Yes")),
                        ),
                        // Cancellation Button
                        cancel: OutlinedButton(
                          onPressed: () => Get.back(), // Close the dialog
                          child: const Text("No"),
                        ),
                      );
                    },
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // --- This helper widget remains unchanged ---
  Widget _infoCard({required IconData icon, required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
      ),
      padding: const EdgeInsets.all(AppSizes.md),
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkGrey),
          const SizedBox(width: AppSizes.spaceBtwItems),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
