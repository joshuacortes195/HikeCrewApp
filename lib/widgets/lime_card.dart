import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// the rounded lime box, used for crew gear, overall difficulty, the my hikes banner and leave no one behind
class LimeCard extends StatelessWidget {
  const LimeCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
