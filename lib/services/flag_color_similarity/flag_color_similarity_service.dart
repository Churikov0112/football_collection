import 'package:football_collection/features/countries/domain/models/national_team.dart';

class FlagColorSimilarityService {
  Future<Map<String, Map<int, double>>> buildProfilesFromPrecomputed({
    required List<FootballNationalTeamModel> teams,
    required Map<String, dynamic> precomputedColors,
    void Function(int current, int total)? onProgress,
  }) async {
    final profiles = <String, Map<int, double>>{};
    final total = teams.length;

    for (var i = 0; i < total; i++) {
      final team = teams[i];
      final profile = _profileFromPrecomputed(precomputedColors[team.id]);
      if (profile != null) {
        profiles[team.id] = profile;
      }
      onProgress?.call(i + 1, total);
    }

    return profiles;
  }

  List<String> findMostSimilarTeamIds({
    required String targetTeamId,
    required Map<String, Map<int, double>> profiles,
    int limit = 12,
  }) {
    final targetProfile = profiles[targetTeamId];
    if (targetProfile == null) return const [];

    final scored = <MapEntry<String, double>>[];

    for (final entry in profiles.entries) {
      if (entry.key == targetTeamId) continue;

      final score = _histogramIntersection(targetProfile, entry.value);
      if (score > 0) {
        scored.add(MapEntry(entry.key, score));
      }
    }

    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.take(limit).map((e) => e.key).toList(growable: false);
  }

  Map<int, double>? _profileFromPrecomputed(dynamic colorItems) {
    try {
      if (colorItems is! List) return null;
      final profile = <int, double>{};

      for (final item in colorItems) {
        if (item is! Map) continue;
        final hex = item['hex']?.toString();
        final rawWeight = item['weight'];
        final weight = rawWeight is num ? rawWeight.toDouble() : double.tryParse(rawWeight?.toString() ?? '');
        final key = _hexToKey(hex);

        if (key == null || weight == null || weight <= 0) continue;
        profile[key] = weight;
      }

      return profile.isEmpty ? null : profile;
    } catch (_) {
      return null;
    }
  }

  int? _hexToKey(String? hex) {
    if (hex == null) return null;
    final normalized = hex.startsWith('#') ? hex.substring(1) : hex;
    if (normalized.length != 6) return null;
    return int.tryParse(normalized, radix: 16);
  }

  double _histogramIntersection(Map<int, double> first, Map<int, double> second) {
    var score = 0.0;

    final smaller = first.length <= second.length ? first : second;
    final bigger = first.length <= second.length ? second : first;

    for (final entry in smaller.entries) {
      final secondValue = bigger[entry.key];
      if (secondValue == null) continue;
      score += entry.value < secondValue ? entry.value : secondValue;
    }

    return score;
  }
}
