import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hike.dart';
import '../providers/hikes_provider.dart';
import '../theme/app_theme.dart';
import 'add_gear_dialog.dart';
import 'gear_row.dart';
import 'lime_card.dart';

// the gear tab on the hike details screen, the packed count and the shared checklist
class GearTab extends StatelessWidget {
  const GearTab({super.key, required this.hike, required this.onBackToDetails});

  final Hike hike;
  final VoidCallback onBackToDetails; // flips back to the details tab

  // runs when you tap add a shared item, opens the popup and adds what you typed
  Future<void> _addItem(BuildContext context) async {
    final provider = context.read<HikesProvider>();
    final name = await showDialog<String>(
      context: context,
      builder: (_) => const AddGearDialog(),
    );
    if (name != null) provider.addGear(hike.id, name);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // thin photo strip at the top of the gear tab
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            hike.photoPath,
            height: 110,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'A little teamwork. A better day outside.',
          style: text.headlineMedium,
        ),
        const SizedBox(height: 20),
        _crewGearCard(context),
        const SizedBox(height: 28),

        // "Shared checklist" heading and the white list of items
        Text('Shared checklist', style: text.titleLarge),
        const SizedBox(height: 12),
        _checklist(context),
        const SizedBox(height: 8),

        // add a shared item link under the list
        TextButton.icon(
          onPressed: () => _addItem(context),
          icon: const Icon(Icons.add),
          label: const Text('Add a shared item'),
        ),
        const SizedBox(height: 16),

        // back to hike details button at the bottom of the gear tab
        OutlinedButton(
          onPressed: onBackToDetails,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
          ),
          child: const Text('Back to hike details'),
        ),
      ],
    );
  }

  // lime crew gear card with "3 of 5 packed" and the progress bar
  Widget _crewGearCard(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final total = hike.gear.length;
    final packed = hike.packedCount;

    return LimeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Crew gear', style: text.titleLarge),
          const SizedBox(height: 4),
          Text(
            '$packed of $total packed',
            style: text.bodyMedium?.copyWith(color: AppColors.darkGreen),
          ),
          const SizedBox(height: 14),
          // the bar fills up as the crew packs, empty if there's no gear yet
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : packed / total,
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }

  // white card with one row per gear item, or a friendly message if it's empty
  Widget _checklist(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: hike.gear.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Nothing on the list yet. Add the first item.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : Column(
              children: [
                for (final item in hike.gear) ...[
                  GearRow(hikeId: hike.id, item: item),
                  if (item != hike.gear.last) const Divider(),
                ],
              ],
            ),
    );
  }
}
