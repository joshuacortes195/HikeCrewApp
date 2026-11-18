import 'package:flutter/material.dart';

import '../models/hike.dart';
import 'labeled_field.dart';

// the none, limited or good toggle on the create hike form
class CellServicePicker extends StatelessWidget {
  const CellServicePicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final CellService selected;
  final ValueChanged<CellService> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel('Cell service'),
        const SizedBox(height: 8),
        // one segment per option, the picked one turns dark green
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<CellService>(
            showSelectedIcon: false,
            segments: [
              for (final s in CellService.values)
                ButtonSegment(value: s, label: Text(s.label)),
            ],
            selected: {selected},
            onSelectionChanged: (picked) => onChanged(picked.first),
          ),
        ),
      ],
    );
  }
}
