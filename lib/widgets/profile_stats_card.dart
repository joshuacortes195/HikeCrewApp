import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/current_user.dart';
import '../providers/hikes_provider.dart';
import '../theme/app_theme.dart';

// week 2: white card on the profile with hikes joined, hikes hosted and since '26
class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // counted from the hike list, so joining or hosting bumps these right away
    final provider = context.watch<HikesProvider>();
    final since = "Since '${memberSinceYear % 100}";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      // three stats with thin lines between them
      child: IntrinsicHeight(
        child: Row(
          children: [
            _stat(context, '${provider.joinedCount}', 'hikes joined'),
            const VerticalDivider(),
            _stat(context, '${provider.hostedCount}', 'hikes hosted'),
            const VerticalDivider(),
            _stat(context, since, 'on the trail'),
          ],
        ),
      ),
    );
  }

  // one stat, the big number with its small grey label underneath
  Widget _stat(BuildContext context, String value, String label) {
    final text = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          Text(value, style: text.titleLarge),
          const SizedBox(height: 2),
          Text(label, style: text.bodySmall),
        ],
      ),
    );
  }
}
