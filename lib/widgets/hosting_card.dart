import 'package:flutter/material.dart';

import '../models/hike.dart';
import '../theme/app_theme.dart';

// the small card under "You are hosting" on my hikes, with a manage hike link
class HostingCard extends StatelessWidget {
  const HostingCard({super.key, required this.hike, required this.onTap});

  final Hike hike;
  final VoidCallback onTap; // opens the hike details

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    // white box with rounded corners, the whole thing is tappable
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // little square photo on the left
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  hike.photoPath,
                  width: 76,
                  height: 76,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),

              // orange date, the title, how many are going and the manage link
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hike.shortDateLine,
                      style: text.labelLarge?.copyWith(
                        color: AppColors.orange,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(hike.title, style: text.titleMedium),
                    const SizedBox(height: 2),
                    Text('${hike.goingCount} going', style: text.bodySmall),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: onTap,
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('Manage hike →'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
