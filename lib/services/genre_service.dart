import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/music_genre.dart';

class GenreService {
  GenreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _genres =>
      _firestore.collection('genres');

  Stream<List<MusicGenre>> watchGenres() async* {
    try {
      await for (final snapshot in _genres.orderBy('name').snapshots()) {
        final genres = snapshot.docs
            .map((doc) => MusicGenre.fromMap(doc.id, doc.data()))
            .toList();
        yield genres.isEmpty ? await loadSeedGenres() : genres;
      }
    } catch (_) {
      yield await loadSeedGenres();
    }
  }

  Future<MusicGenre?> getGenre(String id) async {
    try {
      final doc = await _genres.doc(id).get();
      if (doc.exists && doc.data() != null) {
        return MusicGenre.fromMap(doc.id, doc.data()!);
      }
    } catch (_) {
      // If Firebase is not configured, keep the local demo usable.
    }

    final seedGenres = await loadSeedGenres();
    return seedGenres.where((genre) => genre.id == id).firstOrNull;
  }

  Future<int> seedGenresIfEmpty() async {
    final existing = await _genres.limit(1).get();
    if (existing.docs.isNotEmpty) return 0;

    final raw = await rootBundle.loadString('assets/genres_seed.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    final batch = _firestore.batch();

    for (final item in decoded.whereType<Map<String, dynamic>>()) {
      final id = item['id'] as String;
      final genre = MusicGenre.fromMap(id, item);
      batch.set(_genres.doc(id), genre.toMap());
    }

    await batch.commit();
    return decoded.length;
  }

  Future<List<MusicGenre>> loadSeedGenres() async {
    final raw = await rootBundle.loadString('assets/genres_seed.json');
    final decoded = jsonDecode(raw) as List<dynamic>;

    return decoded.whereType<Map<String, dynamic>>().map((item) {
      final id = item['id'] as String;
      return MusicGenre.fromMap(id, item);
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
