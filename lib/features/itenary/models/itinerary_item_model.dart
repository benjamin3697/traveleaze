import 'package:cloud_firestore/cloud_firestore.dart';

class ItineraryItemModel {
  final String id;
  final String title;
  final String imagePath;
  final String category;
  final Timestamp addedAt;

  ItineraryItemModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.category,
    required this.addedAt,
  });

  /// Create an ItineraryItemModel from a Firestore document snapshot.
  factory ItineraryItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ItineraryItemModel.empty();
    final data = document.data()!;
    return ItineraryItemModel(
      id: document.id,
      title: data['Title'] ?? '',
      imagePath: data['ImagePath'] ?? '',
      category: data['Category'] ?? '',
      addedAt: data['AddedAt'] ?? Timestamp.now(),
    );
  }

  static ItineraryItemModel empty() => ItineraryItemModel(id: '', title: '', imagePath: '', category: '', addedAt: Timestamp.now());
}
