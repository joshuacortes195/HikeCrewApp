import 'package:flutter/material.dart';

import '../models/hike.dart';
import '../theme/app_theme.dart';
import 'lime_card.dart';
import 'pill_label.dart';

// week 2: lime overall difficulty card on the create hike form, the pill changes as you type miles and gain
class DifficultyCard extends StatelessWidget {
  const DifficultyCard({super.key, required this.miles, required this.feet});

  final double? miles; // null until the miles box has a real number
  final int? feet;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final ready = miles != null && feet != null;

    return LimeCard(
      child: Row(
        children: [
          // title and the hint about how it's worked out
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overall difficulty', style: text.titleMedium),
                const SizedBox(height: 4),
                Text(
                  'Based on miles and elevation gain',
                  style: text.bodySmall?.copyWith(color: AppColors.darkGreen),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // uses the same rule as every hike card
          PillLabel(
            text: ready ? difficultyFor(miles!, feet!).label : '—',
            color: AppColors.darkGreen,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
