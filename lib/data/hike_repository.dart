import '../models/gear_item.dart';
import '../models/hike.dart';
import 'current_user.dart';

// where the hikes on the all hikes screen come from, hardcoded for now so a real backend can swap in later
class HikeRepository {
  // hands the hikes to the provider when the app opens, like a real server would
  Future<List<Hike>> fetchHikes() async {
    return _sampleHikes();
  }
}

// the next time a weekday comes around, so the sample hikes are always upcoming
// weekday uses dart's numbers, 6 is saturday and 7 is sunday
DateTime _next(int weekday, int hour, int minute, {int extraWeeks = 0}) {
  final now = DateTime.now();
  var daysAway = (weekday - now.weekday) % 7;
  if (daysAway == 0) daysAway = 7; // today doesn't count, skip to next week
  final day = DateTime(
    now.year,
    now.month,
    now.day + daysAway + extraWeeks * 7,
  );
  return DateTime(day.year, day.month, day.day, hour, minute);
}

// the three sample hikes, eagle rock, fern dell and griffith
List<Hike> _sampleHikes() => [
  Hike(
    id: 'eagle-rock',
    title: 'Sunrise at Eagle Rock',
    trailName: 'Eagle Rock Trail',
    location: 'Topanga, CA',
    meetingSpot: 'Trippet Ranch parking lot',
    dateTime: _next(DateTime.saturday, 7, 0),
    miles: 4.6,
    elevationGainFeet: 850,
    cellService: CellService.limited,
    hostName: 'Joshua Cortes',
    joinedNames: [
      currentUserName,
      'Joshua',
      'Maya',
      'Leo',
      'Priya',
      'Sam',
      'Ava',
      'Diego',
    ],
    gear: [
      GearItem(
        id: 'er-first-aid',
        name: 'First-aid kit',
        claimedBy: currentUserName,
        packed: true,
      ),
      GearItem(
        id: 'er-snacks',
        name: 'Trail snacks',
        claimedBy: 'Joshua',
        packed: true,
      ),
      GearItem(id: 'er-map', name: 'Offline map', claimedBy: 'Joshua'),
      GearItem(id: 'er-blanket', name: 'Emergency blanket'),
      GearItem(id: 'er-filter', name: 'Water filter'),
    ],
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
    dateTime: _next(DateTime.sunday, 9, 0),
    miles: 2.2,
    elevationGainFeet: 280,
    cellService: CellService.good,
    hostName: 'Joshua',
    joinedNames: ['Joshua', 'Maya', 'Leo', 'Priya', 'Sam'],
    gear: [
      GearItem(
        id: 'fd-sunscreen',
        name: 'Sunscreen',
        claimedBy: 'Joshua',
        packed: true,
      ),
      GearItem(id: 'fd-bug-spray', name: 'Bug spray'),
    ],
    planText:
        'A slow walk under the trees with plenty of shade. '
        'Bring water and comfy shoes, coffee after is optional.',
    photoPath: 'assets/images/forest.jpg',
  ),
  Hike(
    id: 'griffith',
    title: 'Sunday at Griffith',
    trailName: 'Mount Hollywood Trail',
    location: 'Los Angeles, CA',
    meetingSpot: 'Griffith Observatory lower lot',
    dateTime: _next(DateTime.sunday, 8, 30, extraWeeks: 1),
    miles: 4.0,
    elevationGainFeet: 750,
    cellService: CellService.good,
    hostName: currentUserName,
    joinedNames: [currentUserName, 'Maya', 'Leo', 'Ava', 'Diego', 'Nora'],
    gear: [
      GearItem(id: 'gr-first-aid', name: 'First-aid kit'),
      GearItem(id: 'gr-water', name: 'Extra water'),
    ],
    planText:
        'Up to the top for the city view, then back down for breakfast. '
        'Bring water, a hat and a light jacket.',
    photoPath: 'assets/images/rock.jpg',
  ),
];
