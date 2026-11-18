import 'date_text.dart';
import 'gear_item.dart';

// how much signal you get on the trail, shows as "Limited service" on cards and "Limited" in the details stats
enum CellService {
  none('None'),
  limited('Limited'),
  good('Good');

  const CellService(this.label);
  final String label;
}

// how hard a hike is, this is the green pill on the photo and what the filter chips check
enum Difficulty {
  easy('Easy'),
  moderate('Moderate'),
  hard('Hard');

  const Difficulty(this.label);
  final String label;
}

// the easy, moderate or hard rule, shared by every hike and the live pill on the create hike form
Difficulty difficultyFor(double miles, int elevationGainFeet) {
  if (miles >= 8 || elevationGainFeet >= 1500) return Difficulty.hard;
  if (miles < 3 && elevationGainFeet < 400) return Difficulty.easy;
  return Difficulty.moderate;
}

// one group hike, everything a hike card and the details screen need to show
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
    required this.joinedNames,
    required this.gear,
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
  final List<String> joinedNames; // everyone going, the host included
  final List<GearItem> gear; // the shared checklist on the gear tab
  final String planText;
  final String photoPath;

  // figures out the easy, moderate or hard pill from miles and elevation gain
  Difficulty get difficulty => difficultyFor(miles, elevationGainFeet);

  // "8 going" counts the people on the list, so joining updates it right away
  int get goingCount => joinedNames.length;

  // true if the hike hasn't happened yet, splits my hikes into upcoming and past
  bool get isUpcoming => dateTime.isAfter(DateTime.now());

  bool isJoinedBy(String userName) => joinedNames.contains(userName);
  bool isHostedBy(String userName) => hostName == userName;

  // the gear one person is bringing, used for "Your gear: First-aid kit · Packed"
  List<GearItem> gearClaimedBy(String userName) =>
      gear.where((item) => item.claimedBy == userName).toList();

  // how many items are checked off, for "3 of 5 packed" on the gear tab
  int get packedCount => gear.where((item) => item.packed).length;

  // miles for the cards and details stats, shows 4.6 as 4.6 and 5.0 as 5
  String get milesText =>
      miles == miles.roundToDouble() ? miles.toInt().toString() : '$miles';

  // the orange date line on each hike card, like SAT, NOV 7 · 7:00 AM
  String get shortDateLine =>
      '${shortDate(dateTime)} · ${timeText(dateTime)}'.toUpperCase();

  // the "4.6 mi / 850 ft gain / Limited service" line on each hike card
  String get statsLine =>
      '$milesText mi  /  $elevationGainFeet ft gain  /  ${cellService.label} service';

  // makes a copy with a new crew or gear list, used when you join, leave, claim or pack
  Hike copyWith({List<String>? joinedNames, List<GearItem>? gear}) {
    return Hike(
      id: id,
      title: title,
      trailName: trailName,
      location: location,
      meetingSpot: meetingSpot,
      dateTime: dateTime,
      miles: miles,
      elevationGainFeet: elevationGainFeet,
      cellService: cellService,
      hostName: hostName,
      joinedNames: joinedNames ?? this.joinedNames,
      gear: gear ?? this.gear,
      planText: planText,
      photoPath: photoPath,
    );
  }
}
