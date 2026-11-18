import 'package:flutter/material.dart';

// the popup from "+ Add a shared item" on the gear tab, hands back the name you typed
class AddGearDialog extends StatefulWidget {
  const AddGearDialog({super.key});

  @override
  State<AddGearDialog> createState() => _AddGearDialogState();
}

class _AddGearDialogState extends State<AddGearDialog> {
  final _controller = TextEditingController();
  String? _error; // shows under the box if you try to add an empty name

  // cleans up the text box when the popup closes
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // runs when you tap add, empty names aren't allowed
  void _add() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Give the item a name');
      return;
    }
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a shared item'),
      // the item name box, pressing done on the keyboard also adds it
      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        onSubmitted: (_) => _add(),
        decoration: InputDecoration(
          hintText: 'Like headlamps or sunscreen',
          errorText: _error,
        ),
      ),
      // cancel closes without adding, add checks the name first
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _add, child: const Text('Add')),
      ],
    );
  }
}
