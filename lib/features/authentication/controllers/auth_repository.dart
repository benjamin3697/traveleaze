// lib/features/authentication/controllers/auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:traveleaze/common/login&signup/sign_in.dart';
import 'package:traveleaze/features/authentication/controllers/user_controller.dart';
import 'package:traveleaze/features/authentication/data/user_repository.dart';
import 'package:traveleaze/navigation_menu.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final RxBool isLoading = false.obs;

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase. The authStateChanges stream will handle the navigation.
      await _auth.signInWithCredential(credential);

      // No navigation or controller initialization here. The AppWrapper will handle it.
      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Oh Snap!', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Sign Out Logic
  Future<void> signOut() async {
    try {
      // 1. Sign out from providers
      await _googleSignIn.signOut();
      await _auth.signOut();

      // --- 2. CRITICAL FIX: Delete user-specific controllers from memory ---
      // This forces GetX to re-initialize them on the next sign-in.
      if (Get.isRegistered<UserController>()) {
        Get.delete<UserController>(force: true);
      }
      if (Get.isRegistered<UserRepository>()) {
        Get.delete<UserRepository>(force: true);
      }
      // You can also add other user-specific controllers here if you have them.
      // Example: Get.delete<ItineraryController>();

      // 3. Navigate to the SignInScreen
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      Get.snackbar('Oh Snap!', 'Error signing out. Please try again.', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
