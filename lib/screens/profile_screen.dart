import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/favorites_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    required this.user,
    required this.favoritesService,
    required this.favoriteCount,
    super.key,
  });

  final User user;
  final FavoritesService favoritesService;
  final int favoriteCount;

  Future<void> _deleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: const Text(
          'Se borrarán tus favoritos y tu cuenta. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await favoritesService.deleteAllFavorites();
      await AuthService().deleteAccount();
    } on FirebaseAuthException catch (error) {
      if (!context.mounted) return;
      final message = error.code == 'requires-recent-login'
          ? 'Vuelve a iniciar sesión antes de eliminar la cuenta.'
          : 'No se pudo eliminar la cuenta.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
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
                    'Mi perfil',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? 'Sesión activa',
                    style: Theme.of(context).textTheme.bodyMedium,
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
                    'Atlas Sonoro',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Una guía sencilla para explorar subgéneros musicales, ver artistas clave y saltar entre estilos relacionados.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: const Text('Favoritos'),
              subtitle: Text(
                favoriteCount == 1
                    ? 'Tienes 1 género guardado.'
                    : 'Tienes $favoriteCount géneros guardados.',
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.auto_stories_outlined),
              title: Text('Próxima idea'),
              subtitle: Text(
                'Agregar un diario de descubrimiento para anotar nuevos géneros escuchados.',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Cerrar sesión'),
                  onTap: () => AuthService().signOut(),
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: const Text('Eliminar cuenta'),
                  subtitle: const Text(
                    'Borra tu cuenta y tus favoritos guardados.',
                  ),
                  onTap: () => _deleteAccount(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
