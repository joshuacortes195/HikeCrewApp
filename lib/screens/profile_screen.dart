import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/edit_profile_dialog.dart';
import '../widgets/lime_card.dart';
import '../widgets/pill_label.dart';
import '../widgets/profile_stats_card.dart';
import 'login_screen.dart';

// profile tab, the last tab in the bottom nav, your name, bio and hike stats
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
    final user = context.watch<UserProvider>();
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        children: [
          // week 2: banner photo with the "your place in the crew" pill in the corner
          Stack(
            children: [
              Image.asset(
                'assets/images/forest.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Positioned(
                left: 20,
                bottom: 16,
                child: PillLabel(text: 'YOUR PLACE IN THE CREW'),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // week 2: your name and bio, both change when you save edit profile
                Text(user.name, style: text.headlineLarge),
                const SizedBox(height: 6),
                Text(user.bio, style: text.bodyMedium),
                const SizedBox(height: 16),

                // week 2: edit profile button, opens the popup
                OutlinedButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => const EditProfileDialog(),
                  ),
                  child: const Text('Edit profile'),
                ),
                const SizedBox(height: 24),
                const ProfileStatsCard(),
                const SizedBox(height: 24),

                // week 2: lime leave no one behind card
                LimeCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Leave no one behind', style: text.titleLarge),
                      const SizedBox(height: 6),
                      Text(
                        'Wait at every junction and count heads at the top. '
                        'The whole crew heads home together.',
                        style: text.bodyMedium?.copyWith(
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _settings(),
                const SizedBox(height: 16),

                // orange log out link at the bottom
                TextButton(
                  onPressed: () => _logOut(context),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.orange,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text('Log out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // week 2: white card with the three settings rows, they don't do anything yet
  Widget _settings() {
    // week 2: material instead of a plain box so the rows still show the tap ripple
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _settingRow(Icons.notifications_none, 'Notifications'),
          const Divider(),
          _settingRow(Icons.lock_outline, 'Privacy'),
          const Divider(),
          _settingRow(Icons.help_outline, 'Help and support'),
        ],
      ),
    );
  }

  // week 2: one settings row with its icon, label and arrow
  Widget _settingRow(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: AppColors.darkGreen),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right, color: AppColors.grey),
      onTap: () {},
    );
  }
}
