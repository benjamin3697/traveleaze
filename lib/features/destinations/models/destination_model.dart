import 'package:cloud_firestore/cloud_firestore.dart';

class DestinationModel {
  final String id;
  final String title;
  final String description;
  final String imagePath; // Renaming to imageUrl might be clearer
  final String category;  // <-- ADD THIS FIELD

  DestinationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category, // <-- ADD THIS
  });

  factory DestinationModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return DestinationModel.empty();
    final data = document.data()!;
    return DestinationModel(
      id: document.id,
      title: data['Title'] ?? '',
      description: data['Description'] ?? '',
      imagePath: data['ImagePath'] ?? '', // Assumes field name is 'ImagePath' in Firestore
      category: data['Category'] ?? 'Uncategorized', // <-- ADD THIS, with a fallback
    );
  }

  static DestinationModel empty() => DestinationModel(id: '', title: '', description: '', imagePath: '', category: '');
}
