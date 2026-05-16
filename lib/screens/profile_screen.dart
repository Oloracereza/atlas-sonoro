import 'package:flutter/material.dart';

import '../services/genre_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _genreService = GenreService();
  bool _isSeeding = false;

  Future<void> _seedCatalog() async {
    setState(() => _isSeeding = true);
    try {
      final created = await _genreService.seedGenresIfEmpty();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            created == 0
                ? 'El catalogo ya tenia datos.'
                : 'Se cargaron $created generos.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo cargar el catalogo.')),
      );
    } finally {
      if (mounted) setState(() => _isSeeding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Atlas Sonoro',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Wiki interactiva para explorar subgeneros musicales de nicho y sus conexiones.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Firebase',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'La app usa Cloud Firestore para leer el catalogo. Este boton carga la semilla inicial para la demo.',
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _isSeeding ? null : _seedCatalog,
                    icon: _isSeeding
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.cloud_upload_outlined),
                    label: const Text('Cargar catalogo inicial'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.bookmark_outline),
              title: Text('Favoritos simples'),
              subtitle: Text(
                'Los favoritos viven solo mientras la app esta abierta. Es intencional para mantener el MVP sencillo.',
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.auto_stories_outlined),
              title: Text('Modulo futuro'),
              subtitle: Text(
                'Diario de descubrimiento: recomendar un subgenero del dia y medir progreso.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
