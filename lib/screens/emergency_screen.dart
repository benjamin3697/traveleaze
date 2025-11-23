// lib/screens/emergency_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/features/destinations/data/destination_repository.dart';
import 'package:traveleaze/features/destinations/models/emergency_contact.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';
import 'package:url_launcher/url_launcher.dart';


class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  // Instance of the repository
  final destinationRepo = Get.put(DestinationRepository());
  late Future<List<EmergencyContactModel>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _contactsFuture = destinationRepo.getEmergencyContacts();
  }

  @override
  Widget build(BuildContext context) {
    // We remove the Scaffold and use a Material widget to fit into the NavigationMenu
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Emergency Contacts',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // --- DYNAMIC LIST of Emergency Contacts ---
              FutureBuilder<List<EmergencyContactModel>>(
                future: _contactsFuture,
                builder: (context, snapshot) {
                  // Loading State
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error State
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong: ${snapshot.error}'));
                  }

                  // Empty State
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No emergency contacts found.'));
                  }

                  // Success State
                  final contacts = snapshot.data!;
                  return ListView.separated(
                    // These properties are essential for a ListView inside a SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: contacts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSizes.spaceBtwItems),
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return _contactCard(
                        context,
                        title: contact.title,
                        number: contact.number,
                        buttonLabel: contact.buttonLabel,
                        color: AppColors.primary,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // This helper widget remains the same
  Widget _contactCard(BuildContext context,
      {required String title,
        required String number,
        required String buttonLabel,
        Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
        border: Border.all(color: AppColors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(number, style: TextStyle(color: AppColors.darkerGrey)),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _callNumber(context, number),
            icon: const Icon(Icons.call, size: 18),
            label: Text(buttonLabel),
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  // Implemented the actual call functionality with url_launcher
  void _callNumber(BuildContext context, String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch dialer for $number')),
      );
    }
  }
}
