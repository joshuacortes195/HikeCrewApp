import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/hike.dart';
import '../providers/hikes_provider.dart';
import '../theme/app_theme.dart';
import 'pill_label.dart';

// one hike card on the all hikes screen, tap it to open the details screen
class HikeCard extends StatelessWidget {
  const HikeCard({super.key, required this.hike, required this.onTap});

  final Hike hike;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    // makes the whole card tappable, not just the view hike link
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _photo(context),
          const SizedBox(height: 14),

          // orange date and time line under the photo
          Text(
            hike.shortDateLine,
            style: text.labelLarge?.copyWith(
              color: AppColors.orange,
              fontSize: 14,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),

          // hike title, trail and city, and the miles, gain and service line
          Text(hike.title, style: text.titleLarge),
          const SizedBox(height: 4),
          Text('${hike.trailName} · ${hike.location}', style: text.bodyMedium),
          const SizedBox(height: 8),
          Text(
            hike.statsLine,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),

          // bottom row of the card, "8 going · Hosted by Joshua" and the view hike link
          Row(
            children: [
              Expanded(
                child: Text(
                  '${hike.goingCount} going · Hosted by ${hike.hostFirstName}',
                  style: text.bodySmall,
                ),
              ),
              TextButton(onPressed: onTap, child: const Text('View hike →')),
            ],
          ),
        ],
      ),
    );
  }

  // the card's photo with the difficulty pill top left and the bookmark top right
  Widget _photo(BuildContext context) {
    final provider = context.watch<HikesProvider>();
    final saved = provider.isSaved(hike.id);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            hike.photoPath,
            height: 210,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 14,
          left: 14,
          child: PillLabel(text: hike.difficulty.label),
        ),

        // white bookmark button in the top right of the photo, fills in when saved
        Positioned(
          top: 10,
          right: 10,
          child: IconButton.filled(
            onPressed: () => provider.toggleSaved(hike.id),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.darkGreen,
            ),
            tooltip: saved ? 'Remove from saved' : 'Save hike',
            icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
          ),
        ),
      ],
    );
  }
}
