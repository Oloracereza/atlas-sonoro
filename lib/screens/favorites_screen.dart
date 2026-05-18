import 'package:flutter/material.dart';

import '../models/music_genre.dart';
import '../services/genre_service.dart';
import '../widgets/empty_state.dart';
import '../widgets/genre_card.dart';
import 'genre_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({
    required this.favoriteIds,
    required this.onToggleFavorite,
    super.key,
  });

  final Set<String> favoriteIds;
  final ValueChanged<String> onToggleFavorite;
  final GenreService _genreService = GenreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: StreamBuilder<List<MusicGenre>>(
        stream: _genreService.watchGenres(),
        builder: (context, genreSnapshot) {
          if (genreSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (genreSnapshot.hasError) {
            return const EmptyState(
              icon: Icons.cloud_off_outlined,
              title: 'No se pudieron cargar tus favoritos',
              message:
                  'Revisa tu conexión e intenta de nuevo.',
            );
          }

          final genres = genreSnapshot.data ?? [];
          final favorites =
              genres.where((genre) => favoriteIds.contains(genre.id)).toList();

          if (favorites.isEmpty) {
            return const EmptyState(
              icon: Icons.bookmark_border,
              title: 'Sin favoritos todavía',
              message:
                  'Guarda géneros desde Explorar para armar tu biblioteca.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final genre = favorites[index];
              return GenreCard(
                genre: genre,
                isFavorite: true,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GenreDetailScreen(
                      genre: genre,
                      allGenres: genres,
                      favoriteIds: favoriteIds,
                      onToggleFavorite: onToggleFavorite,
                    ),
                  ),
                ),
                onFavorite: () => onToggleFavorite(genre.id),
              );
            },
          );
        },
      ),
    );
  }
}
