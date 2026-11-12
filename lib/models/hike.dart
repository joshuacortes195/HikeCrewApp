import 'date_text.dart';

// how much signal you get on the trail
enum CellService {
  none('None'),
  limited('Limited'),
  good('Good');

  const CellService(this.label);
  final String label;
}

// how hard a hike is, never stored, always worked out
enum Difficulty {
  easy('Easy'),
  moderate('Moderate'),
  hard('Hard');

  const Difficulty(this.label);
  final String label;
}

// one group hike
class Hike {
  const Hike({
    required this.id,
    required this.title,
    required this.trailName,
    required this.location,
    required this.meetingSpot,
    required this.dateTime,
    required this.miles,
    required this.elevationGainFeet,
    required this.cellService,
    required this.hostName,
    required this.goingCount,
    required this.planText,
    required this.photoPath,
  });

  final String id;
  final String title;
  final String trailName;
  final String location;
  final String meetingSpot;
  final DateTime dateTime;
  final double miles;
  final int elevationGainFeet;
  final CellService cellService;
  final String hostName;
  final int goingCount;
  final String planText;
  final String photoPath;

  // figures out difficulty from distance and climb
  Difficulty get difficulty {
    if (miles >= 8 || elevationGainFeet >= 1500) return Difficulty.hard;
    if (miles < 3 && elevationGainFeet < 400) return Difficulty.easy;
    return Difficulty.moderate;
  }

  // host's first name for the cards
  String get hostFirstName => hostName.split(' ').first;

  // shows 4.6 as 4.6 and 5.0 as 5
  String get milesText =>
      miles == miles.roundToDouble() ? miles.toInt().toString() : '$miles';

  // the orange line on cards, like SAT, NOV 7 · 7:00 AM
  String get shortDateLine =>
      '${shortDate(dateTime)} · ${timeText(dateTime)}'.toUpperCase();

  // the stats line on cards
  String get statsLine =>
      '$milesText mi  /  $elevationGainFeet ft gain  /  ${cellService.label} service';
}
