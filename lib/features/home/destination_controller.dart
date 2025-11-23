import 'package:get/get.dart';
import 'package:traveleaze/features/destinations/data/destination_repository.dart';
import 'package:traveleaze/features/destinations/models/destination_model.dart';

class DestinationController extends GetxController {
  static DestinationController get instance => Get.find();

  final _repo = Get.put(DestinationRepository());
  final isLoading = true.obs;

  // State for all destinations, selected category, and search query
  final RxList<DestinationModel> allDestinations = <DestinationModel>[].obs;
  final Rxn<String> selectedCategory = Rxn<String>();
  final RxString searchQuery = ''.obs; // 1. ADD STATE FOR SEARCH QUERY

  // --- MODIFIED COMPUTED PROPERTY ---
  // This now filters by category AND search query.
  RxList<DestinationModel> get filteredDestinations {
    var destinations = allDestinations.toList();

    // Filter by category
    if (selectedCategory.value != null) {
      destinations = destinations
          .where((dest) => dest.category == selectedCategory.value)
          .toList();
    }

    // 2. FILTER BY SEARCH QUERY
    // If a search query exists, filter the results further.
    if (searchQuery.value.isNotEmpty) {
      destinations = destinations
          .where((dest) => dest.title
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    return destinations.obs;
  }

  @override
  void onInit() {
    super.onInit();
    fetchDestinations();
  }

  /// Fetch destinations from the repository
  Future<void> fetchDestinations() async {
    try {
      isLoading.value = true;
      final destinations = await _repo.getAllDestinations();
      allDestinations.assignAll(destinations);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch destinations.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Update the selected category
  void filterByCategory(String? category) {
    selectedCategory.value = category;
  }

  /// 3. ADD METHOD TO UPDATE SEARCH QUERY
  /// This will be called by the search bar's onChanged event.
  void searchDestinations(String query) {
    searchQuery.value = query;
  }
}
