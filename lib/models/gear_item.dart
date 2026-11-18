// one thing on a hike's shared checklist, like the first-aid kit
class GearItem {
  const GearItem({
    required this.id,
    required this.name,
    this.claimedBy = '', // empty means nobody is bringing it yet
    this.packed = false,
  });

  final String id;
  final String name;
  final String claimedBy;
  final bool packed;

  // true once someone has said they'll bring it
  bool get isClaimed => claimedBy.isNotEmpty;

  // only the person who claimed it can check it off
  bool canPack(String userName) => claimedBy == userName;

  // makes a copy with a few things changed, used when you claim or pack an item
  GearItem copyWith({String? claimedBy, bool? packed}) {
    return GearItem(
      id: id,
      name: name,
      claimedBy: claimedBy ?? this.claimedBy,
      packed: packed ?? this.packed,
    );
  }
}
