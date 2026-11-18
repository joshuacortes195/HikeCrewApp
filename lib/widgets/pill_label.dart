import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

// small pill, lime by default, the difficulty label on photos, the joined pill and the crew pill on the profile
class PillLabel extends StatelessWidget {
  const PillLabel({
    super.key,
    required this.text,
    this.color = AppColors.lime,
    this.textColor = AppColors.darkGreen,
  });

  final String text;
  final Color color; // dark green on the lime difficulty card so it stands out
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: ShapeDecoration(color: color, shape: const StadiumBorder()),
      // the text inside the pill
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
