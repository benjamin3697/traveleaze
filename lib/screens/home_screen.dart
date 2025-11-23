import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/common/common_shapes/containers/searchbar.dart';
import 'package:traveleaze/features/authentication/controllers/user_controller.dart';
import 'package:traveleaze/features/home/destination_controller.dart';
import 'package:traveleaze/screens/destination_detail_screen.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize both controllers
    final destinationController = Get.put(DestinationController());
    final userController = Get.put(UserController());

    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header ---
                // 2. Wrap the Text widget in Obx to listen for changes
                Obx(() {
                  // Show a generic message while the user data is loading
                  if (userController.profileLoading.value) {
                    return Text('Welcome Back,',
                        style: Theme.of(context).textTheme.displaySmall);
                  } else {
                    // Display the user's name once it's loaded
                    final fullName = userController.user.value.displayName ?? '';
                    return Text('Welcome Back, ${fullName.split(' ').last}!',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                        ));
                  }
                }),
                Text('Discover your next adventure in Soroti!',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 18,),

                // --- SEARCH BAR (CONNECTED TO CONTROLLER) ---
                AppSearchBar(
                  hintText: 'Search Destinations',
                  // Pass the controller's search method to the onChanged callback
                  onChanged: destinationController.searchDestinations,
                ),

                const SizedBox(height: AppSizes.spaceBtwItems),

                // --- Categories ---
                // ... (rest of the category code remains the same)
                const Text('Explore categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Obx(() => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => destinationController.filterByCategory(null),
                        child: _buildCategoryChip(
                            'All', destinationController.selectedCategory.value == null),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () =>
                            destinationController.filterByCategory('Campus'),
                        child: _buildCategoryChip('Campus',
                            destinationController.selectedCategory.value == 'Campus'),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => destinationController.filterByCategory('Town'),
                        child: _buildCategoryChip('Town',
                            destinationController.selectedCategory.value == 'Town'),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () =>
                            destinationController.filterByCategory('Nearby Trip'),
                        child: _buildCategoryChip('Nearby Trip',
                            destinationController.selectedCategory.value ==
                                'Nearby Trip'),
                      ),
                    ],
                  ),
                )),
                const SizedBox(height: AppSizes.spaceBtwItems),

                // --- Featured Destinations ---
                // ... (The rest of the code remains exactly the same)
                const Text('Featured Destinations',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: AppSizes.spaceBtwItems),

                Obx(() {
                  if (destinationController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // This condition now also reflects search results
                  if (destinationController.filteredDestinations.isEmpty) {
                    return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('No destinations found.'), // More generic message
                        ));
                  }

                  // The list automatically updates based on category and search
                  return Column(
                    children:
                    destinationController.filteredDestinations.map((destination) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppSizes.spaceBtwItems),
                        child: GestureDetector(
                          onTap: () => Get.to(() =>
                              DestinationDetailScreen(destination: destination)),
                          child: _buildDestinationCard(
                            imagePath: destination.imagePath,
                            title: destination.title,
                            description: destination.description,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper widgets do not need any changes ---
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDestinationCard(
      {required String imagePath,
        required String title,
        required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          // Using Image.asset as per your file content
          child: Image.asset(
            (imagePath),
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: double.infinity,
              height: 180,
              color: Colors.grey.shade300,
              child:
              const Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 4),
        Text(description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }
}
