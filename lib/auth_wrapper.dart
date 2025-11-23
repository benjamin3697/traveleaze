// lib/auth_wrapper.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveleaze/common/login&signup/sign_in.dart';
import 'package:traveleaze/features/authentication/data/user_repository.dart';
import 'package:traveleaze/features/authentication/models/user_model.dart';
import 'package:traveleaze/navigation_menu.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loader while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // If user is logged in
        if (snapshot.hasData && snapshot.data != null) {
          // This FutureBuilder is the key. It ensures the user document is created
          // or verified BEFORE showing the main app content.
          return FutureBuilder(
            future: _getOrCreateUserDocument(snapshot.data!),
            builder: (context, userModelSnapshot) {
              if (userModelSnapshot.connectionState == ConnectionState.done) {
                if (userModelSnapshot.hasData) {
                  // User document is confirmed. Navigate to the main app.
                  return const NavigationMenu();
                } else {
                  // Handle rare error case
                  return const Scaffold(body: Center(child: Text('Could not load user profile.')));
                }
              }
              // While creating/fetching the user document, show a loader.
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          );
        }
        // If user is not logged in
        else {
          return const SignInScreen();
        }
      },
    );
  }

  /// Helper function to check for and create a user document in Firestore.
  Future<UserModel?> _getOrCreateUserDocument(User authUser) async {
    try {
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(authUser); // This creates the document if it doesn't exist
      return await userRepository.fetchUserDetails(authUser.uid); // Then we fetch it
    } catch (e) {
      Get.snackbar("Error", "Failed to initialize user data: ${e.toString()}");
      return null;
    }
  }
}
