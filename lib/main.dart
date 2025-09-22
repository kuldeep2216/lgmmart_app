import 'package:flutter/material.dart';
import 'package:lgmmart_app/screens/main_screen.dart';
// ignore: unused_import
import 'package:lgmmart_app/screens/splash_screen.dart';
import 'package:lgmmart_app/services/auth_service.dart';
import 'package:lgmmart_app/services/cart_service.dart';
import 'package:lgmmart_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => CartService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LGMMart',
      theme: AppTheme.lightTheme,
      // The app now ALWAYS starts at the HomeScreen
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
