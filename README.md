# HikeCrew

HikeCrew is a Flutter app for finding public group hikes and going with a crew. You can browse hikes, filter them by difficulty, save the ones you like, and open a hike to see the stats, where to meet and the plan for the day. You can also join hikes, host your own and share a gear checklist with everyone going.

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

## New in week 2

Everything below stays in sync across screens while the app is running. Nothing is saved to disk yet, the state lives in the providers.

- Join hike works and flips to Leave hike, and the going count updates right away. If you're the host you see You are hosting instead
- Details and Gear are a real tab bar on the hike details screen
- Gear tab with a packed count, a progress bar and a shared checklist
  - Claim an unclaimed item and it's yours
  - Only the person who claimed an item can check it off
  - Add a shared item from a small popup (empty names aren't allowed)
- Create hike form, opened from the plus button on All hikes or My hikes
  - Title, meeting spot, date, time, miles, elevation gain and cell service
  - The difficulty pill updates live as you type, using the same rule as above
  - Checks every field before publishing and shows the problem under the box
  - Publishing makes you the host and the first person going, then jumps to My hikes
- My hikes with an Upcoming and Past hikes toggle, the hikes you're going on (with your gear line) and the hikes you're hosting
- Profile with your name and bio, Edit profile, hikes joined and hosted counts, settings rows and Log out
- Sample hike dates are worked out from today, so they always show as upcoming
- The current user's name lives in `lib/data/current_user.dart`

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
  models/          the Hike and GearItem models and date helpers
  data/            where hikes come from (sample data for now) and the current user
  providers/       app state with Provider
  screens/         full screens
  widgets/         reusable pieces like the hike card
```

## Packages

- provider for state
- google_fonts for Inter
- intl for formatting dates and times
