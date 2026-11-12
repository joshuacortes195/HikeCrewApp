import 'package:flutter/material.dart';

import '../models/hike.dart';
import '../widgets/details_tab_bar.dart';
import '../widgets/hike_stats_row.dart';
import '../widgets/meeting_spot_card.dart';
import '../widgets/pill_label.dart';

// hike details screen, opens when you tap a hike card
class HikeDetailsScreen extends StatefulWidget {
  const HikeDetailsScreen({super.key, required this.hike});

  final Hike hike;

  @override
  State<HikeDetailsScreen> createState() => _HikeDetailsScreenState();
}

class _HikeDetailsScreenState extends State<HikeDetailsScreen> {
  // which tab is picked under the title, 0 is details, 1 is gear
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hike = widget.hike;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      // top bar with the back arrow and "Hike details"
      appBar: AppBar(title: const Text('Hike details')),
      body: ListView(
        children: [
          // big photo at the top with the difficulty pill in the bottom left
          Stack(
            children: [
              Image.asset(
                hike.photoPath,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 20,
                bottom: 16,
                child: PillLabel(text: hike.difficulty.label),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // big hike title and "Hosted by Joshua Cortes · 8 going" under the photo
                Text(hike.title, style: text.headlineLarge),
                const SizedBox(height: 10),
                Text(
                  'Hosted by ${hike.hostName} · ${hike.goingCount} going',
                  style: text.bodyMedium,
                ),
                const SizedBox(height: 20),

                // details and gear tabs under the host line
                DetailsTabBar(
                  selectedIndex: _tabIndex,
                  onChanged: (index) => setState(() => _tabIndex = index),
                ),
                const SizedBox(height: 24),

                // everything under the tabs, swaps when you tap details or gear
                if (_tabIndex == 0) _detailsTab(hike) else _gearTab(),
              ],
            ),
          ),
        ],
      ),

      // join hike button stuck to the bottom of the screen, does nothing yet
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: FilledButton(onPressed: () {}, child: const Text('Join hike')),
        ),
      ),
    );
  }

  // details tab, the three stats, the meeting spot card and the plan
  Widget _detailsTab(Hike hike) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HikeStatsRow(hike: hike),
        const SizedBox(height: 24),
        MeetingSpotCard(hike: hike),
        const SizedBox(height: 28),
        // "The plan" heading and the plan text at the bottom of the details tab
        Text('The plan', style: text.titleLarge),
        const SizedBox(height: 8),
        Text(hike.planText, style: text.bodyMedium?.copyWith(fontSize: 16)),
      ],
    );
  }

  // gear tab, just a coming soon message until the checklist is built
  Widget _gearTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          'The shared gear checklist is coming soon.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
