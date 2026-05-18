# Atlas Sonoro

App hecha en Flutter para explorar subgéneros musicales.

La idea es que funcione como una mini guía musical: puedes crear cuenta, buscar géneros, ver información básica, abrir links externos, navegar a géneros relacionados y guardar favoritos.

## Cómo correrla

```powershell
flutter pub get
flutter run
```

Para usar login y favoritos hay que configurar Firebase Auth con email/contraseña y Cloud Firestore.

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
