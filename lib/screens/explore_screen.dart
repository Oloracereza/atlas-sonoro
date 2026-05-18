import 'package:flutter/material.dart';

import '../models/music_genre.dart';
import '../services/genre_service.dart';
import '../widgets/empty_state.dart';
import '../widgets/genre_card.dart';
import 'genre_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({
    required this.favoriteIds,
    required this.onToggleFavorite,
    super.key,
  });

  final Set<String> favoriteIds;
  final ValueChanged<String> onToggleFavorite;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _genreService = GenreService();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explorar')),
      body: StreamBuilder<List<MusicGenre>>(
        stream: _genreService.watchGenres(),
        builder: (context, genreSnapshot) {
          if (genreSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (genreSnapshot.hasError) {
            return const EmptyState(
              icon: Icons.cloud_off_outlined,
              title: 'No se pudieron cargar los géneros',
              message:
                  'Revisa tu conexión e intenta abrir la app de nuevo.',
            );
          }

          final genres = genreSnapshot.data ?? [];
          if (genres.isEmpty) {
            return const EmptyState(
              icon: Icons.library_music_outlined,
              title: 'Todavía no hay géneros',
              message:
                  'Agrega los datos iniciales para empezar la demo.',
            );
          }

          final filtered =
              genres.where((genre) => genre.matches(_query)).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: const InputDecoration(
                  hintText: 'Buscar por género, artista o escena',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${filtered.length} subgéneros',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final genre in filtered)
                GenreCard(
                  genre: genre,
                  isFavorite: widget.favoriteIds.contains(genre.id),
                  onTap: () => _openGenre(genres, genre),
                  onFavorite: () => widget.onToggleFavorite(genre.id),
                ),
            ],
          );
        },
      ),
    );
  }

  void _openGenre(List<MusicGenre> genres, MusicGenre genre) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GenreDetailScreen(
          genre: genre,
          allGenres: genres,
          favoriteIds: widget.favoriteIds,
          onToggleFavorite: widget.onToggleFavorite,
        ),
      ),
    );
  }
}
