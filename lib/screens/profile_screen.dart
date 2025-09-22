import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lgmmart_app/models/user_model.dart'; // <<< THE FIX IS HERE
import 'package:lgmmart_app/services/auth_service.dart';
import 'package:lgmmart_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

// Enum to manage which section is visible
enum ProfileSection { personalInfo, orderHistory, addresses }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileSection _currentSection = ProfileSection.personalInfo;
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Get the user data from AuthService to initialize the text fields
    final authService = Provider.of<AuthService>(context, listen: false);
    _nameController =
        TextEditingController(text: authService.currentUser?.fullName ?? '');
    _emailController =
        TextEditingController(text: authService.currentUser?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to AuthService to get the current user's data
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    // Handle the case where there is no user (should not happen if logic is correct)
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Error: No user logged in.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return _buildWideLayout(user);
          } else {
            return _buildNarrowLayout(user);
          }
        },
      ),
    );
  }

  // Layout for wide screens
  Widget _buildWideLayout(User user) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 280, child: _buildSidebar(user)),
          const SizedBox(width: 24),
          Expanded(child: _buildContentArea()),
        ],
      ),
    );
  }

  // Layout for narrow screens
  Widget _buildNarrowLayout(User user) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSidebar(user),
            const SizedBox(height: 16),
            _buildContentArea(),
          ],
        ),
      ),
    );
  }

  // Sidebar widget
  Widget _buildSidebar(User user) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200'),
            ),
            const SizedBox(height: 12),
            Text(user.fullName,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
            const Divider(height: 32),
            _buildSidebarItem(
              icon: FontAwesomeIcons.user,
              title: 'Personal Information',
              section: ProfileSection.personalInfo,
            ),
            _buildSidebarItem(
              icon: FontAwesomeIcons.boxArchive,
              title: 'Order History',
              section: ProfileSection.orderHistory,
            ),
            _buildSidebarItem(
              icon: FontAwesomeIcons.mapLocationDot,
              title: 'Addresses',
              section: ProfileSection.addresses,
            ),
            const Divider(),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.rightFromBracket,
                  color: Colors.redAccent),
              title: const Text('Logout',
                  style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper for sidebar items
  Widget _buildSidebarItem(
      {required IconData icon,
      required String title,
      required ProfileSection section}) {
    final bool isSelected = _currentSection == section;
    return ListTile(
      leading: FaIcon(icon,
          color: isSelected ? AppColors.primary : AppColors.gray, size: 20),
      title: Text(title,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      tileColor:
          isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () => setState(() => _currentSection = section),
    );
  }

  // Content area that switches based on state
  Widget _buildContentArea() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: switch (_currentSection) {
          ProfileSection.personalInfo => _buildPersonalInfo(),
          ProfileSection.orderHistory =>
            const Center(child: Text('Order History - Coming Soon!')),
          ProfileSection.addresses =>
            const Center(child: Text('Address Book - Coming Soon!')),
        },
      ),
    );
  }

  // Personal info form
  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Personal Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            OutlinedButton(onPressed: () {}, child: const Text('Edit')),
          ],
        ),
        const Divider(height: 30),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Full Name'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email Address'),
          enabled: false,
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: '+1 (555) 123-4567',
          decoration: const InputDecoration(labelText: 'Phone Number'),
        ),
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {/* TODO: Save logic */},
            child: const Text('Save Changes'),
          ),
        ),
      ],
    );
  }
}
