import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/hike_repository.dart';
import 'providers/hikes_provider.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

// starts the app and loads the hikes right away
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HikesProvider(HikeRepository())..loadHikes(),
      child: const HikeCrewApp(),
    ),
  );
}

// the app itself, sets the theme and opens on login
class HikeCrewApp extends StatelessWidget {
  const HikeCrewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HikeCrew',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const LoginScreen(),
    );
  }
}
