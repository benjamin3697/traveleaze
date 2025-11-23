import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:traveleaze/common/widgets/loaders/loaders.dart';
import 'package:traveleaze/features/itenary/controllers/itinerary_controller.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

// Convert to StatelessWidget
class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(ItineraryController());

    // The calendar logic is local and simple, so it can remain here.
    // If it gets complex, it could be moved to the controller.
    final Rx<DateTime> focusedMonth = DateTime.now().obs;
    final Rxn<DateTime> selectedDate = Rxn<DateTime>();

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              const Center(
                child: Text(
                  'Itinerary Planner',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // --- Calendar section (Now using Obx) ---
              Obx(() => _buildCalendar(focusedMonth, selectedDate)),
              const SizedBox(height: 18),

              const Text('My Itinerary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // --- DYNAMIC LIST of Saved Destinations (from controller) ---
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.itineraryItems.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Add destinations to your itinerary to see them here.'),
                    ),
                  );
                }

                return Column(
                  children: controller.itineraryItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
                      child: _buildSavedCard(
                        context,
                        item.imagePath,
                        item.title,
                        // Pass the delete function
                        onDelete: () => controller.removeDestinationFromItinerary(item.id),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the calendar
  Widget _buildCalendar(Rx<DateTime> focusedMonth, Rxn<DateTime> selectedDate) {
    final formattedMonth = DateFormat.yMMMM().format(focusedMonth.value);
    final days = _generateDaysForMonth(focusedMonth.value);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () => focusedMonth.value = DateTime(focusedMonth.value.year, focusedMonth.value.month - 1), icon: const Icon(Icons.chevron_left, color: AppColors.black)),
                Text(formattedMonth, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => focusedMonth.value = DateTime(focusedMonth.value.year, focusedMonth.value.month + 1), icon: const Icon(Icons.chevron_right, color: AppColors.black)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('S'), Text('M'), Text('T'), Text('W'), Text('T'), Text('F'), Text('S'),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: days.map((date) {
                if (date.year == 0) return const SizedBox(width: 36, height: 36);
                final isSelected = selectedDate.value != null && date.isAtSameMomentAs(selectedDate.value!);
                return GestureDetector(
                  onTap: () => selectedDate.value = date,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: isSelected ? AppColors.primary : Colors.transparent, shape: BoxShape.circle),
                    child: Center(child: Text('${date.day}', style: TextStyle(color: isSelected ? Colors.white : AppColors.black))),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Destination card with actions
  Widget _buildSavedCard(BuildContext context, String imagePath, String title, {required VoidCallback onDelete}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset( // Use Image.file for local assets
            (imagePath),
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(color: Colors.grey.shade300, height: 150),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis)),
            Row(
              children: [
                // For now, the "add to date" button is for UI. Can be implemented later.
                IconButton(icon: const Icon(Icons.add_task, color: AppColors.primary), onPressed: () {
                  TLoaders.successSnackBar(title: 'Planned!', message: '$title has been added to your plan for the selected date.');
                }),
                IconButton(icon: const Icon(Icons.delete_outline, color: AppColors.error), onPressed: onDelete),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Calendar day generation logic
  List<DateTime> _generateDaysForMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    int startOffset = firstDayOfMonth.weekday;
    if (startOffset == 7) startOffset = 0; // Adjust for Sunday start
    return List.generate(startOffset + daysInMonth, (index) {
      if (index < startOffset) return DateTime(0);
      return DateTime(month.year, month.month, index - startOffset + 1);
    });
  }
}
