import 'package:flutter_test/flutter_test.dart';
import 'package:hike_crew/data/current_user.dart';
import 'package:hike_crew/data/hike_repository.dart';
import 'package:hike_crew/models/gear_item.dart';
import 'package:hike_crew/providers/hikes_provider.dart';

// grabs one gear item off eagle rock so the tests read easier
GearItem _gear(HikesProvider provider, String gearId) {
  return provider
      .hikeById('eagle-rock')!
      .gear
      .firstWhere((item) => item.id == gearId);
}

void main() {
  late HikesProvider provider;

  // fresh sample hikes before every test
  setUp(() async {
    provider = HikesProvider(HikeRepository());
    await provider.loadHikes();
  });

  // claiming an unclaimed item gives it to you
  test('claim assigns the item to the current user', () {
    provider.claimGear('eagle-rock', 'er-blanket');
    expect(_gear(provider, 'er-blanket').claimedBy, currentUserName);
  });

  // you can't take an item someone else already claimed
  test('claim does nothing if someone already has it', () {
    provider.claimGear('eagle-rock', 'er-map');
    expect(_gear(provider, 'er-map').claimedBy, 'Joshua');
  });

  // only the person who claimed it can check it off
  test('you can only pack your own items', () {
    provider.togglePacked('eagle-rock', 'er-map');
    expect(_gear(provider, 'er-map').packed, false);

    provider.togglePacked('eagle-rock', 'er-first-aid');
    expect(_gear(provider, 'er-first-aid').packed, false);
  });

  // empty names don't get added to the checklist
  test('add gear skips empty names', () {
    provider.addGear('eagle-rock', '   ');
    expect(provider.hikeById('eagle-rock')!.gear.length, 5);
    provider.addGear('eagle-rock', 'Headlamps');
    expect(provider.hikeById('eagle-rock')!.gear.length, 6);
  });

  // joining and leaving moves the going count, and hosts can't leave
  test('join and leave update the going count', () {
    provider.joinHike('fern-dell');
    expect(provider.hikeById('fern-dell')!.goingCount, 6);
    provider.leaveHike('fern-dell');
    expect(provider.hikeById('fern-dell')!.goingCount, 5);

    provider.leaveHike('griffith');
    expect(provider.hikeById('griffith')!.goingCount, 6);
  });
}
