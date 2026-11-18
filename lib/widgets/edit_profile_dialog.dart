import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

// the popup from edit profile, lets you change your name and bio
class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  // starts the boxes filled in with what's on your profile now
  late final _name = TextEditingController(
    text: context.read<UserProvider>().name,
  );
  late final _bio = TextEditingController(
    text: context.read<UserProvider>().bio,
  );
  String? _nameError; // shows under the name box if you clear it

  // cleans up the boxes when the popup closes
  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  // runs when you tap save, your name can't be empty
  void _save() {
    if (_name.text.trim().isEmpty) {
      setState(() => _nameError = 'Your name can\'t be empty');
      return;
    }
    context.read<UserProvider>().updateProfile(
      name: _name.text,
      bio: _bio.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit profile'),
      // the name and bio boxes
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Your name',
              errorText: _nameError,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bio,
            maxLines: 2,
            decoration: const InputDecoration(hintText: 'A line about you'),
          ),
        ],
      ),
      // cancel closes without saving, save updates the profile everywhere
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
