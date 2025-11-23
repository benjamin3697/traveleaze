// lib/features/destinations/models/emergency_contact_model.dart

class EmergencyContactModel {
  final String id;
  final String title;
  final String number;
  final String buttonLabel;

  EmergencyContactModel({
    required this.id,
    required this.title,
    required this.number,
    required this.buttonLabel,
  });

  /// Convert model to a JSON structure for storing in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'number': number,
      'buttonLabel': buttonLabel,
    };
  }

  /// Create a EmergencyContactModel from a Firestore document
  factory EmergencyContactModel.fromSnapshot(Map<String, dynamic> document) {
    return EmergencyContactModel(
      id: document['id'] ?? '',
      title: document['title'] ?? '',
      number: document['number'] ?? '',
      buttonLabel: document['buttonLabel'] ?? '',
    );
  }
}
