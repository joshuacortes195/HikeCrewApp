import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/screen_header.dart';
import 'login_screen.dart';

// placeholder for your profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // sends you back to login and clears every screen behind it
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
          // filler text until this tab gets built
          Text(
            'Your profile and hike stats will show up here.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // orange log out link
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
