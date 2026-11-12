import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/screen_header.dart';
import 'login_screen.dart';

// profile tab, the last tab in the bottom nav, a placeholder for now
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // runs when you tap log out, sends you back to the login screen and clears every screen behind it
  void _logOut(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ScreenHeader(eyebrow: 'A little about you.', title: 'Profile'),
          const SizedBox(height: 40),
          // filler text under the profile title until this tab gets built
          Text(
            'Your profile and hike stats will show up here.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // orange log out link under the filler text
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => _logOut(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.orange,
                padding: EdgeInsets.zero,
              ),
              child: const Text('Log out'),
            ),
          ),
        ],
      ),
    );
  }
}
