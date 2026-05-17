# Checklist de prepublicacion en Google Play

## Estado tecnico

- Target SDK: Android 15 / API 35 configurado en `android/app/build.gradle.kts`.
- Compile SDK: API 36 para compatibilidad con dependencias AndroidX actuales.
- Application ID: `com.lauro.atlassonoro`; cambiarlo solo antes de la primera publicacion si se quiere otro identificador permanente.
- Permisos Android: solo `INTERNET`.
- Login: no aplica; la app no crea cuentas.
- Datos personales: no se solicitan datos personales en el MVP.
- Favoritos: locales en memoria, sin sincronizacion por usuario.

## Pendientes obligatorios antes de enviar a revision

1. Ejecutar `flutterfire configure` y usar un proyecto Firebase real.
2. Crear Cloud Firestore y precargar los 15 generos antes de enviar a Play, o mantener el respaldo local si todavia no se usara Firebase real.
3. Completar Data safety en Play Console:
   - No personal data collected, si mantienes el MVP sin cuentas, anuncios ni analitica.
   - Data encrypted in transit: yes, por Firebase/HTTPS.
4. Completar Content rating: app educativa/musical, sin contenido generado por usuarios en v1.
5. En App access, indicar que no requiere login.
6. Generar un Android App Bundle de release con firma:
   `flutter build appbundle --release`.
7. Revisar el reporte de Pre-launch en Play Console y corregir crashes, ANRs o problemas de compatibilidad.

## Recomendacion para release

Para Play Store, las reglas de Firestore quedan en solo lectura para `genres`. Si se necesita cambiar el catalogo, hazlo desde Firebase Console o con un script administrativo.
