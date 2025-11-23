import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:traveleaze/common/login&signup/sign_in.dart';
import 'package:traveleaze/navigation_menu.dart';
import 'package:traveleaze/screens/home_screen.dart'; // Import HomeScreen
import 'package:traveleaze/utilities/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  /// Checks the current user's authentication state and navigates
  /// to the appropriate screen after a delay.
  void _checkAuthAndNavigate() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if a user is currently logged in
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // If user is logged in, go to the HomeScreen
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const NavigationMenu()));
        } else {
          // If no user is logged in, go to the SignInScreen
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SignInScreen()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed for better logo visibility
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Use the project's logo asset as the splash icon
            Image.asset('assets/logo/logo.png',
                width: 200, height: 200, fit: BoxFit.contain),
            const SizedBox(height: 16),
            const Text('Traveleaze',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
