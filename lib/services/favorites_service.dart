import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  FavoritesService({
    required String uid,
    FirebaseFirestore? firestore,
  })  : _uid = uid,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final String _uid;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _favorites =>
      _firestore.collection('users').doc(_uid).collection('favorites');

  Stream<Set<String>> watchFavoriteIds() {
    return _favorites.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.id).toSet(),
        );
  }

  Future<void> toggleFavorite(String genreId, bool isFavorite) async {
    final doc = _favorites.doc(genreId);
    if (isFavorite) {
      await doc.delete();
    } else {
      await doc.set({
        'genreId': genreId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> deleteAllFavorites() async {
    final snapshot = await _favorites.get();
    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
