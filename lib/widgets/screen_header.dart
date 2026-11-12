import 'package:flutter/material.dart';

// the little grey line plus big title at the top of each tab
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.trailing,
  });

  final String eyebrow;
  final String title;
  final Widget? trailing; // optional button on the right

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // grey intro line and the big heading
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
        // the ? only adds the right side button if one was passed in
        ?trailing,
      ],
    );
  }
}
