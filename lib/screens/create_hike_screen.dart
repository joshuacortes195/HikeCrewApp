import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/current_user.dart';
import '../models/date_text.dart';
import '../models/hike.dart';
import '../providers/hikes_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/cell_service_picker.dart';
import '../widgets/difficulty_card.dart';
import '../widgets/distance_fields.dart';
import '../widgets/labeled_field.dart';

// week 2: create hike form, opens from the plus button on all hikes and my hikes
class CreateHikeScreen extends StatefulWidget {
  const CreateHikeScreen({super.key});

  @override
  State<CreateHikeScreen> createState() => _CreateHikeScreenState();
}

class _CreateHikeScreenState extends State<CreateHikeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _place = TextEditingController();
  final _dateText = TextEditingController();
  final _timeText = TextEditingController();
  final _miles = TextEditingController();
  final _feet = TextEditingController();

  DateTime? _date;
  TimeOfDay? _time;
  CellService _service = CellService.limited;

  // redraws the difficulty pill every time you type in miles or gain
  @override
  void initState() {
    super.initState();
    _miles.addListener(() => setState(() {}));
    _feet.addListener(() => setState(() {}));
  }

  // cleans up all the text boxes when you leave the form
  @override
  void dispose() {
    for (final c in [_title, _place, _dateText, _timeText, _miles, _feet]) {
      c.dispose();
    }
    super.dispose();
  }

  // the date and time put together, null until both are picked
  DateTime? get _when {
    if (_date == null || _time == null) return null;
    return DateTime(
      _date!.year,
      _date!.month,
      _date!.day,
      _time!.hour,
      _time!.minute,
    );
  }

  // opens the calendar popup, past days are greyed out
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked == null) return;
    setState(() {
      _date = picked;
      _dateText.text = longDate(picked);
    });
  }

  // opens the clock popup, starts at 8 am since most hikes start early
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked == null) return;
    setState(() {
      _time = picked;
      _timeText.text = timeText(
        DateTime(2000, 1, 1, picked.hour, picked.minute),
      );
    });
  }

  // checks every box, and if it all looks good adds the hike and closes the form
  void _publish() {
    if (!_formKey.currentState!.validate()) return;
    final place = _place.text.trim();
    final hike = Hike(
      id: 'hike-${DateTime.now().millisecondsSinceEpoch}',
      title: _title.text.trim(),
      trailName: _title.text.trim(),
      location: place,
      meetingSpot: place,
      dateTime: _when!,
      miles: double.parse(_miles.text.trim()),
      elevationGainFeet: int.parse(_feet.text.trim()),
      cellService: _service,
      hostName: currentUserName,
      joinedNames: const [currentUserName], // you're the first one going
      gear: const [],
      planText: 'A new hike from the crew. Bring water, layers and good shoes.',
      photoPath: 'assets/images/rock.jpg',
    );
    context.read<HikesProvider>().addHike(hike);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      // top bar with just the back arrow
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            // small orange "PLAN AN ADVENTURE" label and the big title
            Text(
              'PLAN AN ADVENTURE',
              style: text.labelLarge?.copyWith(
                color: AppColors.orange,
                fontSize: 13,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text('Create hike', style: text.headlineLarge),
            const SizedBox(height: 24),

            // title and meeting spot, both required
            LabeledField(
              label: 'Hike title',
              hint: 'Sunrise at Eagle Rock',
              controller: _title,
              validator: (v) => _required(v, 'Give your hike a title'),
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: 'Location or meeting spot',
              hint: 'Trippet Ranch parking lot',
              controller: _place,
              validator: (v) => _required(v, 'Add where the crew should meet'),
            ),
            const SizedBox(height: 16),

            // date and time boxes, tapping them opens the pickers
            LabeledField(
              label: 'Date',
              hint: 'Pick a day',
              controller: _dateText,
              readOnly: true,
              onTap: _pickDate,
              suffixIcon: const Icon(Icons.calendar_today_outlined),
              validator: (_) => _checkDate(),
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: 'Time',
              hint: 'Pick a start time',
              controller: _timeText,
              readOnly: true,
              onTap: _pickTime,
              suffixIcon: const Icon(Icons.schedule),
              validator: (_) => _checkTime(),
            ),
            const SizedBox(height: 16),

            // miles and elevation side by side, both have to be numbers
            DistanceFields(
              miles: _miles,
              feet: _feet,
              milesValid: _parsedMiles != null,
              feetValid: _parsedFeet != null,
            ),
            const SizedBox(height: 20),

            // none, limited or good picker for cell service
            CellServicePicker(
              selected: _service,
              onChanged: (picked) => setState(() => _service = picked),
            ),
            const SizedBox(height: 24),

            // lime difficulty card that updates as you type
            DifficultyCard(miles: _parsedMiles, feet: _parsedFeet),
            const SizedBox(height: 28),

            // big green publish button at the bottom of the form
            FilledButton(
              onPressed: _publish,
              child: const Text('Publish hike'),
            ),
          ],
        ),
      ),
    );
  }

  // the miles and feet as real numbers, null if the box is empty or not a number
  double? get _parsedMiles {
    final miles = double.tryParse(_miles.text.trim());
    return miles != null && miles > 0 ? miles : null;
  }

  int? get _parsedFeet {
    final feet = int.tryParse(_feet.text.trim());
    return feet != null && feet >= 0 ? feet : null;
  }

  // shows the message under a box if it's left empty
  String? _required(String? value, String message) {
    return (value == null || value.trim().isEmpty) ? message : null;
  }

  // the date can't be missing or in the past
  String? _checkDate() {
    if (_date == null) return 'Pick a date for the hike';
    final now = DateTime.now();
    if (_date!.isBefore(DateTime(now.year, now.month, now.day))) {
      return 'That date has already passed';
    }
    return null;
  }

  // the time can't be missing, or already gone if the hike is today
  String? _checkTime() {
    if (_time == null) return 'Pick a start time';
    if (_when != null && _when!.isBefore(DateTime.now())) {
      return 'That time has already passed today';
    }
    return null;
  }
}
