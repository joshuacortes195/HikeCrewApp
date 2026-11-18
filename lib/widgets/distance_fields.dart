import 'package:flutter/material.dart';

import 'labeled_field.dart';

// the miles and elevation gain boxes side by side on the create hike form
class DistanceFields extends StatelessWidget {
  const DistanceFields({
    super.key,
    required this.miles,
    required this.feet,
    required this.milesValid,
    required this.feetValid,
  });

  final TextEditingController miles;
  final TextEditingController feet;
  // the form tells us if each box has a real number in it
  final bool milesValid;
  final bool feetValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // miles box, decimals allowed
        Expanded(
          child: LabeledField(
            label: 'Distance (mi)',
            hint: '4.6',
            controller: miles,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (_) => milesValid ? null : 'Enter miles, like 4.6',
          ),
        ),
        const SizedBox(width: 12),
        // elevation gain box, whole feet only
        Expanded(
          child: LabeledField(
            label: 'Elevation gain (ft)',
            hint: '850',
            controller: feet,
            keyboardType: TextInputType.number,
            validator: (_) => feetValid ? null : 'Enter feet, like 850',
          ),
        ),
      ],
    );
  }
}
