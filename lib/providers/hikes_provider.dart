import 'package:flutter/foundation.dart';

import '../data/hike_repository.dart';
import '../models/hike.dart';

// holds the hike list, the filter, the search and saved hikes for the whole app
class HikesProvider extends ChangeNotifier {
  HikesProvider(this._repository);

  final HikeRepository _repository;

  List<Hike> _hikes = [];
  bool _isLoading = false;
  Difficulty? _selectedDifficulty; // null means all hikes
  String _searchText = '';
  final Set<String> _savedIds = {};

  bool get isLoading => _isLoading;
  Difficulty? get selectedDifficulty => _selectedDifficulty;

  // loads hikes from the repository when the app starts
  Future<void> loadHikes() async {
    _isLoading = true;
    notifyListeners();
    _hikes = await _repository.fetchHikes();
    _isLoading = false;
    notifyListeners();
  }

  // the hikes that match the chip and the search bar
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

  // filters the list by difficulty
  void selectDifficulty(Difficulty? difficulty) {
    _selectedDifficulty = difficulty;
    notifyListeners();
  }

  // updates the list as you type in the search bar
  void search(String text) {
    _searchText = text.trim();
    notifyListeners();
  }

  bool isSaved(String hikeId) => _savedIds.contains(hikeId);

  // adds or removes the hike from the saved list
  void toggleSaved(String hikeId) {
    if (_savedIds.contains(hikeId)) {
      _savedIds.remove(hikeId);
    } else {
      _savedIds.add(hikeId);
    }
    notifyListeners();
  }
}
