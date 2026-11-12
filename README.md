# HikeCrew

HikeCrew is a Flutter app for finding public group hikes and going with a crew. You can browse hikes, filter them by difficulty, save the ones you like, and open a hike to see the stats, where to meet and the plan for the day. Later on you'll be able to join hikes, host your own and share a gear checklist with everyone going.

This is my final project for my mobile app class, built over 4 weeks.

## What works right now (week 1)

- Login screen (no real accounts yet, log in or sign up just takes you in)
- Home with a bottom nav for All hikes, My hikes and Profile
- All hikes list with search, difficulty filters and a bookmark on each hike
- Hike details with the stats, meeting spot and the plan
- Difficulty is worked out from miles and elevation gain
  - Easy: under 3 miles and under 400 ft
  - Hard: 8+ miles or 1500+ ft
  - Moderate: everything else

## How to run it

You need Flutter installed and an Android emulator or iOS simulator running.

```
flutter pub get
flutter run
```

To run the tests:

```
flutter test
```

The app downloads the Inter font the first time it opens, so the emulator needs internet.

## Project layout

```
lib/
  main.dart        starts the app
  theme/           colors, fonts and widget styles
  models/          the Hike model and date helpers
  data/            where hikes come from (sample data for now)
  providers/       app state with Provider
  screens/         full screens
  widgets/         reusable pieces like the hike card
```

## Packages

- provider for state
- google_fonts for Inter
