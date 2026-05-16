import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/music_genre.dart';
import '../widgets/section_card.dart';

class GenreDetailScreen extends StatelessWidget {
  const GenreDetailScreen({
    required this.genre,
    required this.allGenres,
    required this.favoriteIds,
    required this.onToggleFavorite,
    super.key,
  });

  final MusicGenre genre;
  final List<MusicGenre> allGenres;
  final Set<String> favoriteIds;
  final ValueChanged<String> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final relatedGenres = allGenres
        .where((candidate) => genre.relatedGenreIds.contains(candidate.id))
        .toList();

    final isFavorite = favoriteIds.contains(genre.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(genre.name),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Quitar favorito' : 'Guardar favorito',
            onPressed: () => onToggleFavorite(genre.id),
            icon: Icon(
              isFavorite ? Icons.bookmark : Icons.bookmark_border,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(
            genre.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            genre.shortDescription,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Escena',
            child: Text(genre.scene),
          ),
          SectionCard(
            title: 'Rasgos sonoros',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final item in genre.characteristics)
                  Chip(label: Text(item)),
              ],
            ),
          ),
          SectionCard(
            title: 'Artistas clave',
            child: _BulletList(items: genre.keyArtists),
          ),
          SectionCard(
            title: 'Discos para empezar',
            child: _BulletList(items: genre.keyRecords),
          ),
          SectionCard(
            title: 'Conexiones',
            child: relatedGenres.isEmpty
                ? const Text('Sin conexiones registradas.')
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final related in relatedGenres)
                        ActionChip(
                          label: Text(related.name),
                          avatar: const Icon(Icons.hub_outlined, size: 18),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GenreDetailScreen(
                                genre: related,
                                allGenres: allGenres,
                                favoriteIds: favoriteIds,
                                onToggleFavorite: onToggleFavorite,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
          SectionCard(
            title: 'Escuchar o leer mas',
            child: Column(
              children: [
                for (final link in genre.externalLinks)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.open_in_new),
                    title: Text(link.label),
                    subtitle: Text(link.url),
                    onTap: () => _openLink(context, link.url),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace.')),
      );
    }
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                Expanded(child: Text(item)),
              ],
            ),
          ),
      ],
    );
  }
}
