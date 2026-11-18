import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/current_user.dart';
import '../models/hike.dart';
import '../providers/hikes_provider.dart';

// the big button stuck to the bottom of the hike details screen, join, leave or you are hosting
class JoinHikeButton extends StatelessWidget {
  const JoinHikeButton({super.key, required this.hike});

  final Hike hike;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HikesProvider>();

    // hosts can't leave their own hike, so they get a lime button that does nothing
    if (hike.isHostedBy(currentUserName)) {
      return const FilledButton(
        onPressed: null,
        child: Text('You are hosting'),
      );
    }

    // already going, the outlined leave hike button takes you off the crew
    if (hike.isJoinedBy(currentUserName)) {
      return OutlinedButton(
        onPressed: () => provider.leaveHike(hike.id),
        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
        child: const Text('Leave hike'),
      );
    }

    // not going yet, the green join hike button adds you to the crew
    return FilledButton(
      onPressed: () => provider.joinHike(hike.id),
      child: const Text('Join hike'),
    );
  }
}
