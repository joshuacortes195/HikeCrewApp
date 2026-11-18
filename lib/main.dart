import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/hike_repository.dart';
import 'providers/hikes_provider.dart';
import 'providers/user_provider.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

// starts the app, loads the hikes in the background and sets up your profile
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HikesProvider(HikeRepository())..loadHikes(),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const HikeCrewApp(),
    ),
  );
}

// the app itself, applies our green and cream theme and opens on the login screen
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
