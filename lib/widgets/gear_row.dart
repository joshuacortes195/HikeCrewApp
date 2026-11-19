import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/current_user.dart';
import '../models/gear_item.dart';
import '../providers/hikes_provider.dart';

// week 2: one row on the shared checklist, the checkbox, the item name, who has it and the claim button
class GearRow extends StatelessWidget {
  const GearRow({super.key, required this.hikeId, required this.item});

  final String hikeId;
  final GearItem item;

  // the grey line under the name, like You · Packed, Joshua · Not packed or Unclaimed
  String get _statusLine {
    if (!item.isClaimed) return 'Unclaimed';
    final who = item.canPack(currentUserName)
        ? 'You'
        : item.claimedBy.split(' ').first;
    return '$who · ${item.packed ? 'Packed' : 'Not packed'}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HikesProvider>();
    final text = Theme.of(context).textTheme;
    final mine = item.canPack(currentUserName);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          // only the person who claimed it can check it off, everyone else sees it greyed out
          Checkbox(
            value: item.packed,
            onChanged: mine
                ? (_) => provider.togglePacked(hikeId, item.id)
                : null,
          ),
          const SizedBox(width: 4),

          // item name with who's bringing it underneath
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: text.titleMedium),
                const SizedBox(height: 2),
                Text(_statusLine, style: text.bodySmall),
              ],
            ),
          ),
          _trailing(context, provider),
        ],
      ),
    );
  }

  // right side of the row, a claim button if nobody has it, or "Claimed" if someone else hasn't packed it yet
  Widget _trailing(BuildContext context, HikesProvider provider) {
    if (!item.isClaimed) {
      return OutlinedButton(
        onPressed: () => provider.claimGear(hikeId, item.id),
        style: OutlinedButton.styleFrom(minimumSize: const Size(80, 44)),
        child: const Text('Claim'),
      );
    }
    if (!item.canPack(currentUserName) && !item.packed) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text('Claimed', style: Theme.of(context).textTheme.bodySmall),
      );
    }
    return const SizedBox.shrink();
  }
}
