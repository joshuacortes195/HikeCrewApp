import 'package:flutter/material.dart';

import '../widgets/screen_header.dart';

// my hikes tab, the middle tab in the bottom nav, a placeholder for now
class MyHikesScreen extends StatelessWidget {
  const MyHikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ScreenHeader(
            eyebrow: 'Your next adventure.',
            title: 'My hikes',
          ),
          const SizedBox(height: 40),
          // filler text under the my hikes title until this tab gets built
          Text(
            'Hikes you join or host will show up here.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
