// lib/screens/splash_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lgmmart_app/screens/home_screen.dart';
import 'package:lgmmart_app/utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // This function will be called when the widget is first created.
    _navigateToHome();
  }

  void _navigateToHome() {
    // Wait for 3 seconds, then navigate away.
    Timer(const Duration(seconds: 30), () {
      // Use pushReplacement to prevent the user from going back to the splash screen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use your app's primary background color for the splash screen
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo image
            Image.asset(
              'assets/images/splash_logo.png', // Make sure your image file is named this!
              width: 500,
            ),
            const SizedBox(height: 2),
            // Optional: add a loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
