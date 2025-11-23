// lib/features/authentication/models/user_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String displayName;
  final String email;
  String phoneNumber;
  String universityId;
  String profilePicture;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    this.phoneNumber = '',
    this.universityId = '',
    this.profilePicture = '',
  });

  /// Helper function to create an empty user model.
  static UserModel empty() => UserModel(id: '', displayName: '', email: '');

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'DisplayName': displayName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'UniversityID': universityId,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firestore document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        displayName: data['DisplayName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        universityId: data['UniversityID'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
