// lib/features/destinations/models/saved_destination_model.dart

class SavedDestinationModel {
  final String id;
  final String title;
  final String imagePath;

  SavedDestinationModel({
    required this.id,
    required this.title,
    required this.imagePath,
  });

  /// Convert model to a JSON structure for storing in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
    };
  }

  /// Create a SavedDestinationModel from a Firestore document
  factory SavedDestinationModel.fromSnapshot(Map<String, dynamic> document) {
    return SavedDestinationModel(
      id: document['id'] ?? '',
      title: document['title'] ?? '',
      imagePath: document['imagePath'] ?? '',
    );
  }
}
