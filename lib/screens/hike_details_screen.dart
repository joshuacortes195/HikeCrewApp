import 'package:flutter/material.dart';

import '../models/hike.dart';
import '../widgets/details_tab_bar.dart';
import '../widgets/hike_stats_row.dart';
import '../widgets/meeting_spot_card.dart';
import '../widgets/pill_label.dart';

// everything about one hike
class HikeDetailsScreen extends StatefulWidget {
  const HikeDetailsScreen({super.key, required this.hike});

  final Hike hike;

  @override
  State<HikeDetailsScreen> createState() => _HikeDetailsScreenState();
}

class _HikeDetailsScreenState extends State<HikeDetailsScreen> {
  int _tabIndex = 0; // 0 is details, 1 is gear

  @override
  Widget build(BuildContext context) {
    final hike = widget.hike;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      // top bar with the back button
      appBar: AppBar(title: const Text('Hike details')),
      body: ListView(
        children: [
          // hero photo with the difficulty pill
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
                // title and host line
                Text(hike.title, style: text.headlineLarge),
                const SizedBox(height: 10),
                Text(
                  'Hosted by ${hike.hostName} · ${hike.goingCount} going',
                  style: text.bodyMedium,
                ),
                const SizedBox(height: 20),

                // details and gear tabs
                DetailsTabBar(
                  selectedIndex: _tabIndex,
                  onChanged: (index) => setState(() => _tabIndex = index),
                ),
                const SizedBox(height: 24),

                // shows whichever tab is picked
                if (_tabIndex == 0) _detailsTab(hike) else _gearTab(),
              ],
            ),
          ),
        ],
      ),

      // join button pinned to the bottom, does nothing yet
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: FilledButton(onPressed: () {}, child: const Text('Join hike')),
        ),
      ),
    );
  }

  // stats, meeting spot and the plan
  Widget _detailsTab(Hike hike) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HikeStatsRow(hike: hike),
        const SizedBox(height: 24),
        MeetingSpotCard(hike: hike),
        const SizedBox(height: 28),
        Text('The plan', style: text.titleLarge),
        const SizedBox(height: 8),
        Text(hike.planText, style: text.bodyMedium?.copyWith(fontSize: 16)),
      ],
    );
  }

  // gear checklist isn't built yet
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
