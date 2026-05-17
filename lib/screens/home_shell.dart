import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/favorites_service.dart';
import 'explore_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({required this.user, super.key});

  final User user;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  late final FavoritesService _favoritesService;

  @override
  void initState() {
    super.initState();
    _favoritesService = FavoritesService(uid: widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Set<String>>(
        stream: _favoritesService.watchFavoriteIds(),
        builder: (context, snapshot) {
          final favoriteIds = snapshot.data ?? {};
          final screens = [
            ExploreScreen(
              favoriteIds: favoriteIds,
              onToggleFavorite: (genreId) => _favoritesService.toggleFavorite(
                genreId,
                favoriteIds.contains(genreId),
              ),
            ),
            FavoritesScreen(
              favoriteIds: favoriteIds,
              onToggleFavorite: (genreId) => _favoritesService.toggleFavorite(
                genreId,
                favoriteIds.contains(genreId),
              ),
            ),
            ProfileScreen(
              user: widget.user,
              favoritesService: _favoritesService,
            ),
          ];

          return screens[_index];
        },
      ),
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
