import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traveleaze/features/authentication/controllers/user_controller.dart';
import 'package:traveleaze/common/widgets/loaders/loaders.dart';
import 'package:traveleaze/features/destinations/models/destination_model.dart';
import 'package:traveleaze/features/itenary/models/itinerary_item_model.dart';
// 1. Import the model for the items you are fetching

class ItineraryController extends GetxController {
  static ItineraryController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 2. Add state variables for loading status and the list of items
  final isLoading = false.obs;
  final RxList<ItineraryItemModel> itineraryItems = <ItineraryItemModel>[].obs;

  // 3. Use onInit to fetch data as soon as the controller is ready
  @override
  void onInit() {
    super.onInit();
    fetchItineraryItems();
  }

  /// 4. Add the method to fetch itinerary items from the user's subcollection
  Future<void> fetchItineraryItems() async {
    try {
      isLoading.value = true;
      final userId = UserController.instance.user.value.id;
      if (userId.isEmpty) {
        // If user is not logged in, ensure the list is empty and stop loading
        itineraryItems.clear();
        return;
      }

      final snapshot = await _db
          .collection('Users')
          .doc(userId)
          .collection('Itinerary')
          .orderBy('AddedAt', descending: true) // Show newest items first
          .get();

      final items = snapshot.docs.map((doc) => ItineraryItemModel.fromSnapshot(doc)).toList();
      itineraryItems.assignAll(items);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Failed to fetch your itinerary. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Adds a destination to the current user's itinerary subcollection.
  Future<void> addDestinationToItinerary(DestinationModel destination) async {
    try {
      final userId = UserController.instance.user.value.id;
      if (userId.isEmpty) {
        TLoaders.warningSnackBar(title: 'Authentication Required', message: 'You must be logged in to add to your itinerary.');
        return;
      }

      final itineraryRef = _db.collection('Users').doc(userId).collection('Itinerary').doc(destination.id);

      final doc = await itineraryRef.get();
      if (doc.exists) {
        TLoaders.warningSnackBar(title: 'Already Added', message: '${destination.title} is already in your itinerary.');
        return;
      }

      await itineraryRef.set({
        'Title': destination.title,
        'ImagePath': destination.imagePath,
        'Category': destination.category,
        'AddedAt': FieldValue.serverTimestamp(),
      });

      TLoaders.successSnackBar(title: 'Added to Itinerary!', message: '${destination.title} has been added to your personal itinerary.');

      // 5. Refresh the list after adding a new item
      fetchItineraryItems();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong. Please try again.');
    }
  }

  /// Removes a destination from the user's itinerary.
  Future<void> removeDestinationFromItinerary(String destinationId) async {
    try {
      final userId = UserController.instance.user.value.id;
      if (userId.isEmpty) return;

      await _db.collection('Users').doc(userId).collection('Itinerary').doc(destinationId).delete();

      // This local removal is good, but a full refresh is safer if order matters.
      // The `fetchItineraryItems()` call below is a more robust alternative.
      itineraryItems.removeWhere((item) => item.id == destinationId);

      TLoaders.successSnackBar(title: 'Removed', message: 'The destination has been removed from your itinerary.');

      // Optionally, call fetchItineraryItems() again to ensure data consistency
      // await fetchItineraryItems();

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Failed to remove the item. Please try again.');
    }
  }
}
