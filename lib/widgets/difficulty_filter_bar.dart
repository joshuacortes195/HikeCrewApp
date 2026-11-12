import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/hike.dart';
import '../providers/hikes_provider.dart';
import '../theme/app_theme.dart';

// the row of chips that filters the list by difficulty
class DifficultyFilterBar extends StatelessWidget {
  const DifficultyFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HikesProvider>();
    // null is the all hikes chip
    final options = <Difficulty?>[null, ...Difficulty.values];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final option in options)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _chip(provider, option),
            ),
        ],
      ),
    );
  }

  // one chip, dark green when it's picked
  Widget _chip(HikesProvider provider, Difficulty? option) {
    final selected = provider.selectedDifficulty == option;

    return ChoiceChip(
      label: Text(option?.label ?? 'All hikes'),
      selected: selected,
      onSelected: (_) => provider.selectDifficulty(option),
      labelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: selected ? AppColors.white : AppColors.darkGreen,
      ),
    );
  }
}
