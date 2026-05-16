import 'package:atlas_sonoro/models/music_genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MusicGenre search matches core fields', () {
    final genre = MusicGenre.fromMap('trip-hop', {
      'name': 'Trip hop',
      'shortDescription': 'Bristol sound lento y oscuro',
      'scene': 'Bristol',
      'characteristics': ['breakbeats'],
      'keyArtists': ['Massive Attack'],
      'keyRecords': ['Blue Lines'],
      'relatedGenreIds': ['downtempo'],
      'externalLinks': [],
    });

    expect(genre.matches('massive'), isTrue);
    expect(genre.matches('bristol'), isTrue);
    expect(genre.matches('salsa'), isFalse);
  });
}
