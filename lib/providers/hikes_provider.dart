import 'package:flutter/foundation.dart';

import '../data/current_user.dart';
import '../data/hike_repository.dart';
import '../models/gear_item.dart';
import '../models/hike.dart';

// the app's shared memory, the hike list, who's going, the gear, which chip is picked, search and bookmarks
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

  // finds one hike by id, the details screen uses this so it always shows the latest version
  Hike? hikeById(String hikeId) {
    for (final hike in _hikes) {
      if (hike.id == hikeId) return hike;
    }
    return null;
  }

  // the you are going cards on my hikes, upcoming hikes you joined, soonest first
  List<Hike> get upcomingJoined => _sorted(
    _hikes.where((h) => h.isUpcoming && h.isJoinedBy(currentUserName)),
  );

  // the you are hosting cards on my hikes, upcoming hikes you host
  List<Hike> get hosting => _sorted(
    _hikes.where((h) => h.isUpcoming && h.isHostedBy(currentUserName)),
  );

  // the past hikes toggle on my hikes, hikes you went on that already happened
  List<Hike> get pastHikes => _sorted(
    _hikes.where((h) => !h.isUpcoming && h.isJoinedBy(currentUserName)),
  ).reversed.toList();

  // the hikes joined and hikes hosted numbers on the profile
  int get joinedCount =>
      _hikes.where((h) => h.isJoinedBy(currentUserName)).length;
  int get hostedCount =>
      _hikes.where((h) => h.isHostedBy(currentUserName)).length;

  // puts hikes in date order, soonest first
  List<Hike> _sorted(Iterable<Hike> hikes) =>
      hikes.toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  // runs when you tap join hike, adds you to the crew so the going count goes up
  void joinHike(String hikeId) {
    final hike = hikeById(hikeId);
    if (hike == null || hike.isJoinedBy(currentUserName)) return;
    _replace(
      hike.copyWith(joinedNames: [...hike.joinedNames, currentUserName]),
    );
  }

  // runs when you tap leave hike, takes you off the crew, the host can't leave their own hike
  void leaveHike(String hikeId) {
    final hike = hikeById(hikeId);
    if (hike == null || hike.isHostedBy(currentUserName)) return;
    final crew = hike.joinedNames.where((n) => n != currentUserName).toList();
    _replace(hike.copyWith(joinedNames: crew));
  }

  // adds the new hike from the create hike form to our list
  void addHike(Hike hike) {
    _hikes = [..._hikes, hike];
    notifyListeners();
  }

  // runs when you tap claim on the gear tab, only works if nobody has it yet
  void claimGear(String hikeId, String gearId) {
    _updateGear(hikeId, gearId, (item) {
      if (item.isClaimed) return item;
      return item.copyWith(claimedBy: currentUserName);
    });
  }

  // runs when you tap a checkbox on the gear tab, only the person who claimed it can check it off
  void togglePacked(String hikeId, String gearId) {
    _updateGear(hikeId, gearId, (item) {
      if (!item.canPack(currentUserName)) return item;
      return item.copyWith(packed: !item.packed);
    });
  }

  // runs from the add a shared item dialog, adds the item as unclaimed
  void addGear(String hikeId, String name) {
    final hike = hikeById(hikeId);
    final cleanName = name.trim();
    if (hike == null || cleanName.isEmpty) return;
    final item = GearItem(
      id: '$hikeId-${DateTime.now().microsecondsSinceEpoch}',
      name: cleanName,
    );
    _replace(hike.copyWith(gear: [...hike.gear, item]));
  }

  // changes one gear item on one hike, shared by claim and pack
  void _updateGear(
    String hikeId,
    String gearId,
    GearItem Function(GearItem item) change,
  ) {
    final hike = hikeById(hikeId);
    if (hike == null) return;
    final gear = [
      for (final item in hike.gear) item.id == gearId ? change(item) : item,
    ];
    _replace(hike.copyWith(gear: gear));
  }

  // swaps the old version of a hike for the new one and tells every screen to redraw
  void _replace(Hike updated) {
    _hikes = [for (final h in _hikes) h.id == updated.id ? updated : h];
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
