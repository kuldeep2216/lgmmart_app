// lib/models/user_model.dart

class User {
  final String fullName;
  final String email;
  final String password; // In a real app, this would be hashed!

  User({
    required this.fullName,
    required this.email,
    required this.password,
  });
}
