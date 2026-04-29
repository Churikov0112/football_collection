import 'dart:math';

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
    Map<String, String>? englishNamesByTeamId,
    int limit = 12,
    double colorWeight = 0.3,
    double nameWeight = 0.7,
  }) {
    final targetProfile = profiles[targetTeamId];
    if (targetProfile == null) return const [];
    final targetName = englishNamesByTeamId?[targetTeamId];
    final normalizedColorWeight = colorWeight.clamp(0, 1).toDouble();
    final normalizedNameWeight = nameWeight.clamp(0, 1).toDouble();
    final totalWeight = normalizedColorWeight + normalizedNameWeight;
    final hasNames =
        targetName != null &&
        targetName.isNotEmpty &&
        englishNamesByTeamId != null;

    final scored = <MapEntry<String, double>>[];

    for (final entry in profiles.entries) {
      if (entry.key == targetTeamId) continue;

      final colorScore = _histogramIntersection(targetProfile, entry.value);
      var score = colorScore;

      if (hasNames && totalWeight > 0) {
        final candidateName = englishNamesByTeamId[entry.key] ?? '';
        final nameScore = _nameSimilarity(targetName, candidateName);
        score =
            ((colorScore * normalizedColorWeight) +
                (nameScore * normalizedNameWeight)) /
            totalWeight;
      }

      if (score <= 0) continue;
      scored.add(MapEntry(entry.key, score));
    }

    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.take(limit).map((e) => e.key).toList(growable: false);
  }

  List<String> findMostSimilarByColorTeamIds({
    required String targetTeamId,
    required Map<String, Map<int, double>> profiles,
    int limit = 12,
  }) {
    final targetProfile = profiles[targetTeamId];
    if (targetProfile == null) return const [];

    final scored = <MapEntry<String, double>>[];
    for (final entry in profiles.entries) {
      if (entry.key == targetTeamId) continue;
      final colorScore = _histogramIntersection(targetProfile, entry.value);
      if (colorScore <= 0) continue;
      scored.add(MapEntry(entry.key, colorScore));
    }

    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.take(limit).map((e) => e.key).toList(growable: false);
  }

  List<String> findMostSimilarByNameTeamIds({
    required String targetTeamId,
    required Map<String, String> englishNamesByTeamId,
    int limit = 12,
  }) {
    final targetName = englishNamesByTeamId[targetTeamId];
    if (targetName == null || targetName.isEmpty) return const [];

    final scored = <MapEntry<String, double>>[];
    for (final entry in englishNamesByTeamId.entries) {
      if (entry.key == targetTeamId) continue;
      final nameScore = _nameSimilarity(targetName, entry.value);
      if (nameScore <= 0) continue;
      scored.add(MapEntry(entry.key, nameScore));
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
        final weight = rawWeight is num
            ? rawWeight.toDouble()
            : double.tryParse(rawWeight?.toString() ?? '');
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

  double _histogramIntersection(
    Map<int, double> first,
    Map<int, double> second,
  ) {
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

  double _nameSimilarity(String first, String second) {
    final left = _normalizeName(first);
    final right = _normalizeName(second);
    if (left.isEmpty || right.isEmpty) return 0;
    if (left == right) return 1;

    final levenshteinDistance = _levenshtein(left, right);
    final maxLength = max(left.length, right.length);
    final normalizedLevenshtein = maxLength == 0
        ? 0.0
        : 1 - (levenshteinDistance / maxLength);
    final prefixScore = _commonPrefixLength(left, right) / maxLength;
    final suffixScore = _commonSuffixLength(left, right) / maxLength;

    return (normalizedLevenshtein * 0.75) +
        (prefixScore * 0.1) +
        (suffixScore * 0.15);
  }

  String _normalizeName(String value) {
    return value.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
  }

  int _levenshtein(String source, String target) {
    if (source.isEmpty) return target.length;
    if (target.isEmpty) return source.length;

    final previous = List<int>.generate(target.length + 1, (i) => i);
    final current = List<int>.filled(target.length + 1, 0);

    for (var i = 1; i <= source.length; i++) {
      current[0] = i;
      for (var j = 1; j <= target.length; j++) {
        final substitutionCost =
            source.codeUnitAt(i - 1) == target.codeUnitAt(j - 1) ? 0 : 1;
        current[j] = min(
          min(current[j - 1] + 1, previous[j] + 1),
          previous[j - 1] + substitutionCost,
        );
      }

      for (var j = 0; j < previous.length; j++) {
        previous[j] = current[j];
      }
    }

    return previous[target.length];
  }

  int _commonPrefixLength(String source, String target) {
    final maxLength = min(source.length, target.length);
    var length = 0;
    while (length < maxLength &&
        source.codeUnitAt(length) == target.codeUnitAt(length)) {
      length++;
    }
    return length;
  }

  int _commonSuffixLength(String source, String target) {
    final maxLength = min(source.length, target.length);
    var length = 0;
    while (length < maxLength &&
        source.codeUnitAt(source.length - 1 - length) ==
            target.codeUnitAt(target.length - 1 - length)) {
      length++;
    }
    return length;
  }
}
