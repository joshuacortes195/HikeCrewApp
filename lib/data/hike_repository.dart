import '../models/hike.dart';

// where hikes come from, hardcoded for now so a real backend can swap in later
class HikeRepository {
  // hands back the sample hikes like a real server would
  Future<List<Hike>> fetchHikes() async {
    return _sampleHikes;
  }
}

// the two sample hikes from the design
final _sampleHikes = [
  Hike(
    id: 'eagle-rock',
    title: 'Sunrise at Eagle Rock',
    trailName: 'Eagle Rock Trail',
    location: 'Topanga, CA',
    meetingSpot: 'Trippet Ranch parking lot',
    dateTime: DateTime(2026, 11, 7, 7, 0),
    miles: 4.6,
    elevationGainFeet: 850,
    cellService: CellService.limited,
    hostName: 'Joshua Cortes',
    goingCount: 8,
    planText:
        'A relaxed climb, a summit snack, and a good crew. '
        'Bring 2L of water, layers, and sturdy shoes.',
    photoPath: 'assets/images/rock.jpg',
  ),
  Hike(
    id: 'fern-dell',
    title: 'An easy morning outside',
    trailName: 'Fern Dell',
    location: 'Los Angeles, CA',
    meetingSpot: 'Fern Dell Drive entrance',
    dateTime: DateTime(2026, 11, 8, 9, 0),
    miles: 2.2,
    elevationGainFeet: 280,
    cellService: CellService.good,
    hostName: 'Joshua',
    goingCount: 5,
    planText:
        'A slow walk under the trees with plenty of shade. '
        'Bring water and comfy shoes, coffee after is optional.',
    photoPath: 'assets/images/forest.jpg',
  ),
];
