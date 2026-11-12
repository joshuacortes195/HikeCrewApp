import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

// small lime pill, the easy, moderate or hard label on hike card photos and the details photo
class PillLabel extends StatelessWidget {
  const PillLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: const ShapeDecoration(
        color: AppColors.lime,
        shape: StadiumBorder(),
      ),
      // dark green text inside the pill
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.darkGreen,
        ),
      ),
    );
  }
}
