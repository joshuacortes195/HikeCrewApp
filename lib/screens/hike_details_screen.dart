import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hike.dart';
import '../providers/hikes_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/gear_tab.dart';
import '../widgets/hike_stats_row.dart';
import '../widgets/join_hike_button.dart';
import '../widgets/meeting_spot_card.dart';
import '../widgets/pill_label.dart';

// runs when you tap a hike card, view hike or manage hike, opens the hike details screen
void openHikeDetails(BuildContext context, Hike hike) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => HikeDetailsScreen(hike: hike)));
}

// hike details screen, opens when you tap a hike card
class HikeDetailsScreen extends StatefulWidget {
  const HikeDetailsScreen({super.key, required this.hike});

  final Hike hike;

  @override
  State<HikeDetailsScreen> createState() => _HikeDetailsScreenState();
}

class _HikeDetailsScreenState extends State<HikeDetailsScreen>
    with SingleTickerProviderStateMixin {
  // week 2: runs the details and gear tabs under the title
  late final TabController _tabs = TabController(length: 2, vsync: this);

  // week 2: redraws the screen when you switch tabs so the right content shows
  @override
  void initState() {
    super.initState();
    _tabs.addListener(() => setState(() {}));
  }

  // week 2: cleans up the tabs when you leave the screen
  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // week 2: grabs the latest version of this hike so joins and gear changes show right away
    final hike =
        context.watch<HikesProvider>().hikeById(widget.hike.id) ?? widget.hike;
    final hostName = context.watch<UserProvider>().nameFor(hike.hostName);
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
                  'Hosted by $hostName · ${hike.goingCount} going',
                  style: text.bodyMedium,
                ),
                const SizedBox(height: 20),

                // details and gear tabs under the host line
                TabBar(
                  controller: _tabs,
                  tabs: const [
                    Tab(text: 'Details'),
                    Tab(text: 'Gear'),
                  ],
                ),
                const SizedBox(height: 24),

                // everything under the tabs, swaps when you tap details or gear
                if (_tabs.index == 0)
                  _detailsTab(hike)
                else
                  GearTab(
                    hike: hike,
                    onBackToDetails: () => _tabs.animateTo(0),
                  ),
              ],
            ),
          ),
        ],
      ),

      // week 2: join, leave or you are hosting button stuck to the bottom of the screen
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: JoinHikeButton(hike: hike),
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
}
