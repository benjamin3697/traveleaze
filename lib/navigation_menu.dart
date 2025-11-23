import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:traveleaze/screens/emergency_screen.dart';
import 'package:traveleaze/screens/home_screen.dart';
import 'package:traveleaze/screens/intinerary_screen.dart';
import 'package:traveleaze/screens/profile_screen.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(NavigationController());
    final darkMode=AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
              (){
            // determine colors for unselected state based on theme
            final unselectedColor = darkMode ? AppColors.white : Colors.black;
            return NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: darkMode ? AppColors.white.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1),
                // icon color depending on selection state
                iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
                  if (states.contains(WidgetState.selected)) return const IconThemeData(color: AppColors.primary);
                  return IconThemeData(color: unselectedColor);
                }),
                // label text style depending on selection state
                labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
                  if (states.contains(WidgetState.selected)) return const TextStyle(color: AppColors.primary);
                  return TextStyle(color: unselectedColor);
                }),
              ),
              child: NavigationBar(
                height: 80,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                backgroundColor: darkMode ? AppColors.black : Colors.white,
                onDestinationSelected: (index) => controller.selectedIndex.value = index,
                destinations: [
                  const NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
                  const NavigationDestination(icon: Icon(Iconsax.calendar), label: 'Intinerary'),
                  const NavigationDestination(icon: Icon(Iconsax.call_calling), label: 'Emergency'),
                  const NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
                ],
              ),
            );
          }
      ),
      body:Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}
class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  // Make sure all these screens DO NOT have their own Scaffold
  final screens = [
    const HomeScreen(),
    const ItineraryScreen(),
    EmergencyScreen(), // Should be const if possible
    const ProfileScreen(), // Should be const if possible
  ];
}
