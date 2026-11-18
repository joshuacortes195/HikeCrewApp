import 'package:intl/intl.dart';

// short date like Sat, Nov 7, used in the orange date line on each hike card
String shortDate(DateTime d) => DateFormat('EEE, MMM d').format(d);

// long date like Saturday, November 7, used in the meeting spot card and the create hike date box
String longDate(DateTime d) => DateFormat('EEEE, MMMM d').format(d);

// time like 7:00 AM, shows on the hike cards, the meeting spot card and the create hike time box
String timeText(DateTime d) => DateFormat('h:mm a').format(d);
