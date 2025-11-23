// lib/features/destinations/data/destination_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Or your preferred feedback method
import 'package:traveleaze/features/destinations/models/destination_model.dart';
import 'package:traveleaze/features/destinations/models/emergency_contact.dart';
import 'package:traveleaze/features/destinations/models/saved_destination_model.dart'; // Import the new model
import 'package:traveleaze/utilities/constants/image_strings.dart'; // Import your image strings

class DestinationRepository extends GetxController { // Or extends ChangeNotifier if using Provider
  static DestinationRepository get instance => Get.find(); // Or use Provider.of

  final _db = FirebaseFirestore.instance;

  // --- Existing getAllDestinations() method remains here ---
  Future<List<DestinationModel>> getAllDestinations() async {
    // ... same as before
    try {
      final snapshot = await _db.collection('destinations').get();
      final list = snapshot.docs.map((doc) => DestinationModel(
        id: doc.id,
        title: doc['title'],
        description: doc['description'],
        imagePath: doc['imagePath'],
        category: doc['category'],
      )).toList();
      return list;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch destinations: ${e.toString()}');
      return [];
    }
  }

  // --- Existing uploadDummyData() method for HomeScreen remains here ---
  Future<void> uploadDummyData() async {
    // ... same as before
  }


  Future<List<EmergencyContactModel>> getEmergencyContacts() async {
    try {
      final snapshot = await _db.collection('emergency_contacts').orderBy('id').get();
      return snapshot.docs.map((doc) => EmergencyContactModel.fromSnapshot(doc.data())).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch emergency contacts: ${e.toString()}');
      return [];
    }
  }

  // --- NEW: One-time upload for emergency contacts ---
  Future<void> uploadEmergencyContacts() async {
    try {
      final List<EmergencyContactModel> dummyContacts = [
        EmergencyContactModel(id: '1', title: 'Police Emergency', number: '+256783242510', buttonLabel: 'Call Police'),
        EmergencyContactModel(id: '2', title: 'Soroti Health Centre', number: '+256709124383', buttonLabel: 'Call Health'),
        EmergencyContactModel(id: '3', title: 'University Admin', number: '+256750234567', buttonLabel: 'Call Admin'),
        EmergencyContactModel(id: '4', title: 'Guild Office', number: '+256712345678', buttonLabel: 'Call Guild'),
      ];

      final batch = _db.batch();
      for (var contact in dummyContacts) {
        final docRef = _db.collection('emergency_contacts').doc(contact.id);
        batch.set(docRef, contact.toJson());
      }
      await batch.commit();

      Get.snackbar('Success', 'Dummy emergency contacts have been uploaded.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload emergency contacts: ${e.toString()}');
    }
  }


  // --- NEW: Method to get saved destinations ---
  Future<List<SavedDestinationModel>> getSavedDestinations() async {
    try {
      final snapshot = await _db.collection('saved_destinations').get();
      return snapshot.docs.map((doc) => SavedDestinationModel.fromSnapshot(doc.data())).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch saved destinations: ${e.toString()}');
      return [];
    }
  }

  // --- NEW: One-time upload for saved destinations ---
  Future<void> uploadSavedDestinations() async {
    try {
      final List<SavedDestinationModel> dummySaved = [
        SavedDestinationModel(id: '1', title: 'SunCity, Soroti', imagePath: AppImages.suncity),
        SavedDestinationModel(id: '2', title: 'Soroti Rock', imagePath: AppImages.rock),
        SavedDestinationModel(id: '3', title: 'Akello Hotel', imagePath: AppImages.akelloHotel),
      ];

      final batch = _db.batch();
      for (var dest in dummySaved) {
        final docRef = _db.collection('saved_destinations').doc(dest.id);
        batch.set(docRef, dest.toJson());
      }
      await batch.commit();

      Get.snackbar('Success', 'Dummy saved destinations have been uploaded.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload saved destinations: ${e.toString()}');
    }
  }
}
