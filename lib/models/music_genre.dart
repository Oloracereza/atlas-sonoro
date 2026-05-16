import 'external_link.dart';

class MusicGenre {
  const MusicGenre({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.scene,
    required this.characteristics,
    required this.keyArtists,
    required this.keyRecords,
    required this.relatedGenreIds,
    required this.externalLinks,
  });

  final String id;
  final String name;
  final String shortDescription;
  final String scene;
  final List<String> characteristics;
  final List<String> keyArtists;
  final List<String> keyRecords;
  final List<String> relatedGenreIds;
  final List<ExternalLink> externalLinks;

  factory MusicGenre.fromMap(String id, Map<String, dynamic> map) {
    return MusicGenre(
      id: id,
      name: map['name'] as String? ?? '',
      shortDescription: map['shortDescription'] as String? ?? '',
      scene: map['scene'] as String? ?? '',
      characteristics: _stringList(map['characteristics']),
      keyArtists: _stringList(map['keyArtists']),
      keyRecords: _stringList(map['keyRecords']),
      relatedGenreIds: _stringList(map['relatedGenreIds']),
      externalLinks: ((map['externalLinks'] as List<dynamic>?) ?? [])
          .whereType<Map<String, dynamic>>()
          .map(ExternalLink.fromMap)
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shortDescription': shortDescription,
      'scene': scene,
      'characteristics': characteristics,
      'keyArtists': keyArtists,
      'keyRecords': keyRecords,
      'relatedGenreIds': relatedGenreIds,
      'externalLinks': externalLinks.map((link) => link.toMap()).toList(),
      'searchText': [
        name,
        shortDescription,
        scene,
        ...characteristics,
        ...keyArtists,
        ...keyRecords,
      ].join(' ').toLowerCase(),
    };
  }

  bool matches(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return true;

    return [
      name,
      shortDescription,
      scene,
      ...characteristics,
      ...keyArtists,
      ...keyRecords,
    ].join(' ').toLowerCase().contains(normalized);
  }

  static List<String> _stringList(dynamic value) {
    return ((value as List<dynamic>?) ?? [])
        .whereType<String>()
        .where((item) => item.trim().isNotEmpty)
        .toList();
  }
}
