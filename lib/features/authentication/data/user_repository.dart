import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // <-- FIX: Add this import
import 'package:traveleaze/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance; // Instance of Firebase Storage


  /// Creates a user document in Firestore ONLY if it doesn't already exist.
  Future<void> saveUserRecord(User user) async {
    try {
      final userDocRef = _db.collection("Users").doc(user.uid);
      final doc = await userDocRef.get();

      if (!doc.exists) {
        final newUser = UserModel(
          id: user.uid,
          displayName: user.displayName ?? '',
          email: user.email ?? '',
          profilePicture: user.photoURL ?? '',
          universityId: '2301600084@sun.ac.ug', // Default value
          phoneNumber: user.phoneNumber ?? '',
        );
        await userDocRef.set(newUser.toJson());
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong creating your profile.", snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<UserModel> fetchCurrentUserDetails() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) return UserModel.empty();

      return await fetchUserDetails(firebaseUser.uid);
    } catch (e) {
      throw 'Something went wrong while fetching User Information.';
    }
  }

  /// --- NEW: Function to update user details in Firestore ---
  Future<void> updateUserDetails(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection("Users").doc(uid).update(data);
    } catch (e) {
      throw 'Failed to update user details.';
    }
  }

  /// --- NEW: Function to update a single field in a user's document ---
  Future<void> updateSingleField(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection("Users").doc(uid).update(data);
    } catch (e) {
      throw 'Failed to update user data.';
    }
  }

  /// --- NEW: Function to upload any image to Firebase Storage ---
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = _storage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw 'Something went wrong uploading the image.';
    }
  }

  /// Fetches a user's details from Firestore by their UID.
  Future<UserModel> fetchUserDetails(String uid) async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      throw 'Failed to fetch user details.';
    }
  }
}
