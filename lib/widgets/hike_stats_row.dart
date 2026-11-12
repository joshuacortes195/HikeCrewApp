import 'package:flutter/material.dart';

import '../models/hike.dart';
import '../theme/app_theme.dart';

// the three big numbers on the details screen
class HikeStatsRow extends StatelessWidget {
  const HikeStatsRow({super.key, required this.hike});

  final Hike hike;

  @override
  Widget build(BuildContext context) {
    // intrinsic height lets the dividers stretch to match the stats
    return IntrinsicHeight(
      child: Row(
        children: [
          _stat(context, hike.milesText, 'miles'),
          const VerticalDivider(width: 32),
          _stat(context, '${hike.elevationGainFeet} ft', 'elevation gain'),
          const VerticalDivider(width: 32),
          _stat(context, hike.cellService.label, 'cell service'),
        ],
      ),
    );
  }

  // one number with its little label underneath
  Widget _stat(BuildContext context, String value, String label) {
    final text = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: text.headlineMedium?.copyWith(
              fontSize: 26,
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: text.bodySmall),
        ],
      ),
    );
  }
}
