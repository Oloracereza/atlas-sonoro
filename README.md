# Atlas Sonoro

App hecha en Flutter para explorar subgeneros musicales.

La idea es que funcione como una mini guia musical: puedes crear cuenta, buscar generos, ver informacion basica, abrir links externos, navegar a generos relacionados y guardar favoritos.

## Como correrla

```powershell
flutter pub get
flutter run
```

Para usar login y favoritos hay que configurar Firebase Auth con email/contrasena y Cloud Firestore.

Si no hay Firebase configurado, la app usa el archivo local:

```text
assets/genres_seed.json
```

## Tecnologias

- Flutter
- Dart
- Firebase / Cloud Firestore
- Firebase Auth
- JSON local para datos de prueba
