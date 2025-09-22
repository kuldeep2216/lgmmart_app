// lib/services/auth_service.dart

import 'package:flutter/material.dart';
import 'package:lgmmart_app/models/user_model.dart';

class AuthService with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _currentUser;

  // This is our in-memory "database" of registered users.
  final List<User> _users = [];

  bool get isLoggedIn => _isLoggedIn;
  User? get currentUser => _currentUser;

  // --- REGISTRATION LOGIC ---
  // The method now returns a Future<bool> to indicate success or failure.
  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    // Check if a user with this email already exists
    if (_users.any((user) => user.email.toLowerCase() == email.toLowerCase())) {
      return false; // Registration failed: email already in use
    }

    // If not, create a new user and add them to our list
    final newUser = User(fullName: fullName, email: email, password: password);
    _users.add(newUser);

    // We don't log in the user automatically on register in this simple flow.
    // They will be redirected to the login screen.
    notifyListeners(); // Notify if you want any part of the app to know about the new user count etc.
    return true; // Registration successful
  }

  // --- LOGIN LOGIC ---
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Try to find a user with matching email and password
    try {
      final user = _users.firstWhere(
        (user) =>
            user.email.toLowerCase() == email.toLowerCase() &&
            user.password == password,
      );

      _isLoggedIn = true;
      _currentUser = user;
      notifyListeners(); // This is crucial! It tells the AuthGate to switch screens.
      return true; // Login successful
    } catch (e) {
      // firstWhere throws an error if no element is found
      return false; // Login failed
    }
  }

  // --- LOGOUT LOGIC ---
  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }
}
