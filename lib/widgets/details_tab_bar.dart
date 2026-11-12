import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

// the details and gear tabs under the title on the hike details screen
class DetailsTabBar extends StatelessWidget {
  const DetailsTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [_tab(context, 'Details', 0), _tab(context, 'Gear', 1)],
    );
  }

  // one tab, gets a thick green line under it when it's picked
  Widget _tab(BuildContext context, String label, int index) {
    final selected = index == selectedIndex;

    return Expanded(
      child: InkWell(
        onTap: () => onChanged(index),
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.darkGreen : AppColors.border,
                width: selected ? 3 : 1,
              ),
            ),
          ),
          // tab text, bold and green when picked, grey when not
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? AppColors.darkGreen : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
