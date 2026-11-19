import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/current_user.dart';
import '../models/hike.dart';
import '../providers/hikes_provider.dart';
import '../widgets/create_hike_button.dart';
import '../widgets/hike_card.dart';
import '../widgets/hosting_card.dart';
import '../widgets/lime_card.dart';
import '../widgets/screen_header.dart';
import 'hike_details_screen.dart';

// my hikes tab, the middle tab in the bottom nav, hikes you're going on and hosting
class MyHikesScreen extends StatefulWidget {
  const MyHikesScreen({super.key, required this.onHikePublished});

  final VoidCallback onHikePublished; // keeps you on my hikes after publishing

  @override
  State<MyHikesScreen> createState() => _MyHikesScreenState();
}

class _MyHikesScreenState extends State<MyHikesScreen> {
  bool _showPast =
      false; // which side of the upcoming and past toggle is picked

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HikesProvider>();
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          // week 2: "Your next adventure." and the big title, with the plus button for create hike
          ScreenHeader(
            eyebrow: 'Your next adventure.',
            title: 'My hikes',
            trailing: CreateHikeButton(onPublished: widget.onHikePublished),
          ),
          const SizedBox(height: 20),

          // week 2: upcoming and past hikes toggle, swaps the list below
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: false, label: Text('Upcoming')),
                ButtonSegment(value: true, label: Text('Past hikes')),
              ],
              selected: {_showPast},
              onSelectionChanged: (picked) =>
                  setState(() => _showPast = picked.first),
            ),
          ),
          const SizedBox(height: 20),

          // week 2: lime banner under the toggle
          LimeCard(
            child: Text(
              'More outside. Less group texting.',
              style: text.titleLarge,
            ),
          ),
          const SizedBox(height: 28),

          // week 2: the lists themselves, past hikes or the going and hosting sections
          if (_showPast)
            ..._goingList(
              provider.pastHikes,
              'No past hikes yet. Your first one is coming up.',
            )
          else ...[
            Text('You are going', style: text.titleLarge),
            const SizedBox(height: 14),
            ..._goingList(
              provider.upcomingJoined,
              'You haven\'t joined a hike yet. Find one on All hikes.',
            ),
            const SizedBox(height: 12),
            Text('You are hosting', style: text.titleLarge),
            const SizedBox(height: 14),
            ..._hostingList(provider.hosting),
          ],
        ],
      ),
    );
  }

  // week 2: one big hike card per hike with the joined pill and your gear line, or a friendly message
  List<Widget> _goingList(List<Hike> hikes, String emptyMessage) {
    if (hikes.isEmpty) return [_empty(emptyMessage)];
    return [
      for (final hike in hikes)
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: HikeCard(
            hike: hike,
            showJoined: true,
            note: _gearLine(hike),
            onTap: () => openHikeDetails(context, hike),
          ),
        ),
    ];
  }

  // week 2: one small card per hike you host, or a nudge to make one
  List<Widget> _hostingList(List<Hike> hikes) {
    if (hikes.isEmpty) {
      return [_empty('Not hosting anything yet. Tap + to plan a hike.')];
    }
    return [
      for (final hike in hikes)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: HostingCard(
            hike: hike,
            onTap: () => openHikeDetails(context, hike),
          ),
        ),
    ];
  }

  // week 2: "Your gear: First-aid kit · Packed", only if you've claimed something on that hike
  String? _gearLine(Hike hike) {
    final mine = hike.gearClaimedBy(currentUserName);
    if (mine.isEmpty) return null;
    final items = mine.map(
      (item) => '${item.name} · ${item.packed ? 'Packed' : 'Not packed'}',
    );
    return 'Your gear: ${items.join(', ')}';
  }

  // week 2: grey message when a list is empty
  Widget _empty(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
