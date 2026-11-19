import 'package:flutter/material.dart';

import '../screens/create_hike_screen.dart';

// week 2: the round plus button on all hikes and my hikes, opens the create hike form
class CreateHikeButton extends StatelessWidget {
  const CreateHikeButton({super.key, required this.onPublished});

  final VoidCallback onPublished; // switches over to the my hikes tab

  // opens the form, and if a hike got published, jumps to my hikes and shows a quick message
  Future<void> _open(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final published = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => const CreateHikeScreen()));
    if (published != true) return;
    onPublished();
    messenger.showSnackBar(
      const SnackBar(content: Text('Your hike is live. Time to find a crew.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () => _open(context),
      iconSize: 30,
      style: IconButton.styleFrom(minimumSize: const Size(60, 60)),
      tooltip: 'Create hike',
      icon: const Icon(Icons.add),
    );
  }
}
