# Atlas Sonoro

App hecha en Flutter para explorar subgeneros musicales.

La idea es que funcione como una mini guia musical: puedes buscar generos, ver informacion basica, abrir links externos, navegar a generos relacionados y guardar favoritos.

## Como correrla

```powershell
flutter pub get
flutter run
```

Si se quiere probar Firebase, se puede configurar un proyecto de Firebase y cargar el catalogo desde la pantalla **Acerca de**.

Si no hay Firebase configurado, la app usa el archivo local:

```text
assets/genres_seed.json
```

## Tecnologias

- Flutter
- Dart
- Firebase / Cloud Firestore
- JSON local para datos de prueba
