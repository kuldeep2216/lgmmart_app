import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lgmmart_app/screens/category_screen.dart';
import 'package:lgmmart_app/screens/checkour_screen.dart';
import 'package:lgmmart_app/screens/home_screen.dart';
import 'package:lgmmart_app/screens/profile_screen.dart';
import 'package:lgmmart_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // This variable will keep track of the currently selected tab index
  int _selectedIndex = 0;

  // This is the list of screens that the navigation bar will switch between.
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryScreen(), // For now, this is a single category, but it represents the tab
    CheckoutScreen(),
    AccountWrapper(), // A special widget to handle login/profile logic
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body will display the widget from our list based on the selected index
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // The Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.tableCellsLarge),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // These properties are important for making the bar look good
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

// This is a helper widget that decides whether to show the Login or Profile screen.
class AccountWrapper extends StatelessWidget {
  const AccountWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the AuthService to know the login state
    final authService = Provider.of<AuthService>(context);

    if (authService.isLoggedIn) {
      return const ProfileScreen();
    } else {
      return const LoginScreen();
    }
  }
}
