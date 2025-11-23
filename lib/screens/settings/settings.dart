import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/features/settings/controllers/settings_controller.dart'; // 1. Import controller
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Initialize the controller
    final controller = Get.put(SettingsController());
    final isCurrentlyDark = Get.isDarkMode;

    return Scaffold(
      // The background color will now be handled by the theme
      appBar: AppBar(
        backgroundColor: isCurrentlyDark ? AppColors.dark : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Color will be handled by theme
          onPressed: () => Get.back(),
        ),
        title: const Text('Settings'), // Style will be handled by theme
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.spaceBtwItems),
              const Text('Appearance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // --- Dark mode row (Now connected to controller) ---
                      Row(
                        children: [
                          const Icon(Icons.nightlight_round, color: Colors.black54),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 4),
                                Text('Toggle between light and dark themes.', style: TextStyle(color: Colors.black54, fontSize: 12)),
                              ],
                            ),
                          ),
                          // 3. Use Obx to make the Switch reactive
                          Obx(() => Switch(
                            value: controller.themeMode.value == ThemeMode.dark,
                            onChanged: controller.toggleDarkMode,
                          )),
                        ],
                      ),
                      const Divider(height: 20),

                      // --- Font size row (Now connected to controller) ---
                      Row(
                        children: [
                          const Icon(Icons.format_size, color: Colors.black54),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Font Size', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Obx(() => Slider(
                                  value: controller.fontSize.value,
                                  min: 0.8,
                                  max: 1.4,
                                  divisions: 6,
                                  onChanged: controller.changeFontSize,
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),

                      // App theme color row
                      //... (This can be implemented later with a color picker dialog)
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),
              const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),

              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.black54),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(height: 4),
                            Text('Receive important updates and alerts.', style: TextStyle(color: Colors.black54, fontSize: 12)),
                          ],
                        ),
                      ),
                      // --- Push notifications row (Now connected to controller) ---
                      Obx(() => Switch(
                        value: controller.pushNotifications.value,
                        onChanged: controller.togglePushNotifications,
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
