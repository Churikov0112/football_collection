import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../features/leaderboard/domain/models/leaderboard_entry.dart';

@singleton
class FirestoreService {
  FirestoreService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _leaderboardCollection = 'leaderboard_countries';

  Future<List<LeaderboardEntry>> getLeaderboard({int limit = 100}) async {
    final snapshot = await _firestore
        .collection(_leaderboardCollection)
        .orderBy('totalCards', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map(
          (doc) => LeaderboardEntry(
            country: (doc.data()['country'] as String?) ?? 'Unknown',
            totalCards: (doc.data()['totalCards'] as num?)?.toInt() ?? 0,
            openingsCount: (doc.data()['openingsCount'] as num?)?.toInt() ?? 0,
          ),
        )
        .toList();
  }

  Future<void> submitPackOpened({
    required String country,
    required int cardsReceivedFromPack,
  }) async {
    final normalizedCountry = country.trim();
    if (normalizedCountry.isEmpty) return;

    final docRef = _firestore.collection(_leaderboardCollection).doc(_docIdByCountry(normalizedCountry));

    await docRef.set({
      'country': normalizedCountry,
      'countryLowercase': normalizedCountry.toLowerCase(),
      'totalCards': FieldValue.increment(cardsReceivedFromPack),
      'openingsCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  String _docIdByCountry(String country) {
    return country.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
  }
}
