import 'package:flutter/material.dart';

import 'all_hikes_screen.dart';
import 'my_hikes_screen.dart';
import 'profile_screen.dart';

// the frame you're in after logging in, holds the three tabs and the bottom nav
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // shows the tab you picked, and keeps the others alive so your scroll spot and search stay put
      body: IndexedStack(
        index: _currentIndex,
        children: const [AllHikesScreen(), MyHikesScreen(), ProfileScreen()],
      ),

      // bottom nav with all hikes, my hikes and profile
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.landscape_outlined),
            selectedIcon: Icon(Icons.landscape),
            label: 'All hikes',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'My hikes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
