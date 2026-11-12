import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hike.dart';
import '../providers/hikes_provider.dart';
import '../widgets/difficulty_filter_bar.dart';
import '../widgets/hike_card.dart';
import '../widgets/screen_header.dart';
import 'hike_details_screen.dart';

// all hikes screen, the first tab, the list of public hikes
class AllHikesScreen extends StatelessWidget {
  const AllHikesScreen({super.key});

  // runs when you tap a hike card or view hike, opens the hike details screen
  void _openHike(BuildContext context, Hike hike) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => HikeDetailsScreen(hike: hike)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HikesProvider>();
    final hikes = provider.visibleHikes;
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          // "Find your next crew." and the big "All hikes" title, with the round plus button on the right that does nothing yet
          ScreenHeader(
            eyebrow: 'Find your next crew.',
            title: 'All hikes',
            trailing: IconButton.filled(
              onPressed: () {},
              iconSize: 30,
              style: IconButton.styleFrom(minimumSize: const Size(60, 60)),
              tooltip: 'Create hike',
              icon: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 20),

          // search bar under the title, filters the cards as you type
          TextField(
            onChanged: provider.search,
            decoration: InputDecoration(
              hintText: 'Search hikes or meeting spots',
              prefixIcon: const Icon(Icons.search),
              enabledBorder: _pillBorder(const Color(0xFFDDDCD2)),
              focusedBorder: _pillBorder(Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(height: 16),
          // the difficulty chips under the search bar
          const DifficultyFilterBar(),
          const SizedBox(height: 20),

          // "A good weekend starts here" heading above the cards
          Text('A good weekend starts here', style: text.titleLarge),
          const SizedBox(height: 4),
          Text('Public hikes · Everyone is welcome', style: text.bodyMedium),
          const SizedBox(height: 16),

          // the bottom part, a spinner while loading, an empty message if a chip has no hikes, or the hike cards
          if (provider.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (hikes.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No hikes here yet. Try another filter.',
                textAlign: TextAlign.center,
                style: text.bodyMedium,
              ),
            )
          else
            for (final hike in hikes)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: HikeCard(
                  hike: hike,
                  onTap: () => _openHike(context, hike),
                ),
              ),
        ],
      ),
    );
  }

  // makes the search bar a rounded pill shape
  OutlineInputBorder _pillBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: BorderSide(color: color),
    );
  }
}
