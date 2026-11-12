// day and month names so we don't need to import an extra package
const _days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

// short date like Sat, Nov 7, used in the orange date line on each hike card
String shortDate(DateTime d) {
  final day = _days[d.weekday - 1].substring(0, 3);
  final month = _months[d.month - 1].substring(0, 3);
  return '$day, $month ${d.day}';
}

// long date like Saturday, November 7, used in the meeting spot card on the details screen
String longDate(DateTime d) {
  return '${_days[d.weekday - 1]}, ${_months[d.month - 1]} ${d.day}';
}

// time like 7:00 AM, shows on the hike cards and the meeting spot card
String timeText(DateTime d) {
  final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final minute = d.minute.toString().padLeft(2, '0');
  final amPm = d.hour < 12 ? 'AM' : 'PM';
  return '$hour:$minute $amPm';
}
