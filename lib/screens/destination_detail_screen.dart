// lib/screens/destination_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/features/destinations/models/destination_model.dart';
import 'package:traveleaze/features/itenary/controllers/itinerary_controller.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class DestinationDetailScreen extends StatelessWidget {
  final DestinationModel destination;

  const DestinationDetailScreen({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItineraryController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          destination.title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                  child: Hero(
                    tag: 'feature_${destination.id}_hero',
                    child: Image.asset(
                      destination.imagePath,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 200,
                        color: AppColors.light,
                        child: const Icon(Icons.broken_image, size: 56, color: AppColors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.title,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems),
                      Text(
                        destination.description,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          // 2. Make the onPressed function async
                          onPressed: () async {
                            // Await the completion of the add operation
                            await controller.addDestinationToItinerary(destination);

                            // 3. Pop the screen after the function completes
                            // Check if the screen is still mounted before popping
                            if (context.mounted) {
                              Get.back();
                            }
                          },
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add to Itinerary'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            elevation: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
