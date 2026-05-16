import 'package:flutter/material.dart';

import '../models/music_genre.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    required this.genre,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
    super.key,
  });

  final MusicGenre genre;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      genre.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  IconButton(
                    tooltip:
                        isFavorite ? 'Quitar favorito' : 'Guardar favorito',
                    onPressed: onFavorite,
                    icon: Icon(
                      isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(genre.shortDescription),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.place_outlined, size: 18),
                    label: Text(genre.scene),
                  ),
                  Chip(
                    avatar: const Icon(Icons.hub_outlined, size: 18),
                    label: Text('${genre.relatedGenreIds.length} conexiones'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
