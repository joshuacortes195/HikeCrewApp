import 'package:flutter/material.dart';

import '../models/date_text.dart';
import '../models/hike.dart';
import '../theme/app_theme.dart';

// white card under the stats on the details screen, says when and where the crew meets
class MeetingSpotCard extends StatelessWidget {
  const MeetingSpotCard({super.key, required this.hike});

  final Hike hike;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      // white box with rounded corners and a soft border
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // orange date at the top of the card, like SATURDAY, NOVEMBER 7
          Text(
            longDate(hike.dateTime).toUpperCase(),
            style: text.labelLarge?.copyWith(
              color: AppColors.orange,
              fontSize: 13,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${timeText(hike.dateTime)} · Meet at the trailhead',
            style: text.titleMedium,
          ),
          const SizedBox(height: 12),

          // the meeting spot, like Trippet Ranch parking lot, with the city under it
          Text(hike.meetingSpot, style: text.bodyLarge),
          const SizedBox(height: 2),
          Text(hike.location, style: text.bodySmall),
        ],
      ),
    );
  }
}
