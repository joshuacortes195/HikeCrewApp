import 'package:flutter/foundation.dart';

import '../data/current_user.dart';

// your profile, the name and bio on the profile tab that edit profile changes
class UserProvider extends ChangeNotifier {
  String _name = currentUserName;
  String _bio = 'Weekend wanderer. Always up for a sunrise.';

  String get name => _name;
  String get bio => _bio;

  // runs when you tap save in the edit profile dialog
  void updateProfile({required String name, required String bio}) {
    _name = name.trim();
    _bio = bio.trim();
    notifyListeners();
  }

  // swaps your saved name for the one you picked, so "Hosted by" shows your edited name
  String nameFor(String savedName) =>
      savedName == currentUserName ? _name : savedName;
}
