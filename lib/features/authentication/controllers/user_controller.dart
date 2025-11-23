// lib/features/authentication/controllers/user_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:traveleaze/features/authentication/data/user_repository.dart';
import 'package:traveleaze/features/authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  /// Rx variable to hold the user model.
  final Rx<UserModel> user = UserModel.empty().obs;
  /// Rx variable for loading state
  final RxBool profileLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // This will now handle both saving and fetching the user record.
    fetchUserRecord();
  }

  /// Fetch user record from Firestore.
  /// This method now also ensures a user record is created if it's missing.
  // Future<void> fetchUserRecord() async {
  //   try {
  //     profileLoading.value = true;
  //     final firebaseUser = FirebaseAuth.instance.currentUser;
  //
  //     // Check if a user is logged in
  //     if (firebaseUser != null) {
  //       // --- KEY CHANGE: Ensure user record exists before fetching ---
  //       // The saveUserRecord method is idempotent; it won't overwrite existing data.
  //       // We create a UserModel from the firebaseUser to pass to saveUserRecord.
  //       final newUser = UserModel(
  //         id: firebaseUser.uid,
  //         email: firebaseUser.email ?? '',
  //         displayName: '',
  //       );
  //       await userRepository.saveUserRecord(newUser as User);
  //       // -------------------------------------------------------------
  //
  //       // Now, fetch the detailed user record from Firestore
  //       final userRecord = await userRepository.fetchUserDetails(firebaseUser.uid);
  //       user.value = userRecord;
  //     }
  //   } catch (e) {
  //     // If fetching fails, create an empty user to avoid null errors in the UI
  //     user(UserModel.empty());
  //     Get.snackbar('Error', 'Failed to fetch user details. Please try again.');
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      // The user record is already created by our AppWrapper logic.
      // Here, we just fetch the details to display them.
      final userRecord = await userRepository.fetchCurrentUserDetails();
      user.value = userRecord;
    } catch (e) {
      user(UserModel.empty()); // In case of an error, show an empty user.
      Get.snackbar('Error', 'Failed to fetch user details.');
    } finally {
      profileLoading.value = false;
    }
  }
}
