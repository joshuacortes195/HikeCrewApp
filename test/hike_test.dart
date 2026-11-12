import 'package:flutter_test/flutter_test.dart';
import 'package:hike_crew/models/hike.dart';

// makes a fake hike with just the miles and feet we want to test
Hike _hike(double miles, int feet) {
  return Hike(
    id: 'test',
    title: 'Test hike',
    trailName: 'Test trail',
    location: 'Somewhere, CA',
    meetingSpot: 'Parking lot',
    dateTime: DateTime(2026, 11, 7, 7),
    miles: miles,
    elevationGainFeet: feet,
    cellService: CellService.good,
    hostName: 'Joshua Cortes',
    goingCount: 1,
    planText: '',
    photoPath: 'assets/images/rock.jpg',
  );
}

void main() {
  // checks the difficulty pill shows the right level for different hikes
  test('short and flat hikes are easy', () {
    expect(_hike(2.2, 280).difficulty, Difficulty.easy);
  });

  test('anything in the middle is moderate', () {
    expect(_hike(4.6, 850).difficulty, Difficulty.moderate);
    expect(_hike(2.5, 400).difficulty, Difficulty.moderate);
    expect(_hike(3, 100).difficulty, Difficulty.moderate);
  });

  test('long or steep hikes are hard', () {
    expect(_hike(8, 200).difficulty, Difficulty.hard);
    expect(_hike(2, 1500).difficulty, Difficulty.hard);
  });

  // checks the orange date line on the hike cards reads right
  test('date line reads like the design', () {
    expect(_hike(4.6, 850).shortDateLine, 'SAT, NOV 7 · 7:00 AM');
  });
}
