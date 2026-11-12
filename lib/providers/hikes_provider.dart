import 'package:flutter/foundation.dart';

import '../data/hike_repository.dart';
import '../models/hike.dart';

// the app's shared memory, the hike list, which chip is picked, what's typed in search and which hikes are bookmarked
class HikesProvider extends ChangeNotifier {
  HikesProvider(this._repository);

  final HikeRepository _repository;

  List<Hike> _hikes = [];
  bool _isLoading = false;
  Difficulty? _selectedDifficulty; // null means the all hikes chip is picked
  String _searchText = '';
  final Set<String> _savedIds = {};

  bool get isLoading => _isLoading;
  Difficulty? get selectedDifficulty => _selectedDifficulty;

  // loads the hikes when the app opens, the all hikes screen shows a spinner until this finishes
  Future<void> loadHikes() async {
    _isLoading = true;
    notifyListeners();
    _hikes = await _repository.fetchHikes();
    _isLoading = false;
    notifyListeners();
  }

  // the cards the all hikes screen actually shows, after the chip and search bar filter them
  List<Hike> get visibleHikes {
    final search = _searchText.toLowerCase();
    return _hikes.where((hike) {
      final matchesDifficulty =
          _selectedDifficulty == null || hike.difficulty == _selectedDifficulty;
      final matchesSearch =
          search.isEmpty ||
          hike.title.toLowerCase().contains(search) ||
          hike.trailName.toLowerCase().contains(search) ||
          hike.location.toLowerCase().contains(search) ||
          hike.meetingSpot.toLowerCase().contains(search);
      return matchesDifficulty && matchesSearch;
    }).toList();
  }

  // runs when you tap a chip on the all hikes screen, filters the list by difficulty
  void selectDifficulty(Difficulty? difficulty) {
    _selectedDifficulty = difficulty;
    notifyListeners();
  }

  // runs as you type in the all hikes search bar, narrows the list
  void search(String text) {
    _searchText = text.trim();
    notifyListeners();
  }

  bool isSaved(String hikeId) => _savedIds.contains(hikeId);

  // runs when you tap the bookmark on a hike card, saves or unsaves that hike
  void toggleSaved(String hikeId) {
    if (_savedIds.contains(hikeId)) {
      _savedIds.remove(hikeId);
    } else {
      _savedIds.add(hikeId);
    }
    notifyListeners();
  }
}
