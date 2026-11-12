import 'package:flutter/material.dart';

// the header at the top of the all hikes, my hikes and profile tabs
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.trailing,
  });

  final String eyebrow;
  final String title;
  final Widget? trailing; // optional button on the right, the plus on all hikes

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // small grey line like "Find your next crew." with the big title under it
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eyebrow, style: text.bodyMedium),
              const SizedBox(height: 4),
              Text(title, style: text.headlineLarge),
            ],
          ),
        ),
        // the ? only adds the right side button if a tab passed one in
        ?trailing,
      ],
    );
  }
}
