import 'package:flutter/material.dart';

import 'explore_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  final Set<String> _favoriteIds = {};

  void _toggleFavorite(String genreId) {
    setState(() {
      if (_favoriteIds.contains(genreId)) {
        _favoriteIds.remove(genreId);
      } else {
        _favoriteIds.add(genreId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      ExploreScreen(
        favoriteIds: _favoriteIds,
        onToggleFavorite: _toggleFavorite,
      ),
      FavoritesScreen(
        favoriteIds: _favoriteIds,
        onToggleFavorite: _toggleFavorite,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.travel_explore_outlined),
            selectedIcon: Icon(Icons.travel_explore),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Acerca de',
          ),
        ],
      ),
    );
  }
}
