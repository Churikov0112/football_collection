import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../domain/models/player.dart';

@singleton
class PlayersRepository {
  List<PlayerModel> allPlayersCache = [];

  Future<void> _ensurePlayersInitialized() async {
    if (allPlayersCache.isEmpty) {
      String jsonString = await rootBundle.loadString('assets/json/players_data.json');
      List<dynamic> data = jsonDecode(jsonString);
      allPlayersCache = await compute(_parsePlayers, data);
    }
  }

  Future<List<PlayerModel>> playersGet([String? countryId]) async {
    await _ensurePlayersInitialized();
    if (countryId == null) return [...allPlayersCache];
    return [...allPlayersCache].where((player) => player.countryId == countryId).toList();
  }

  List<PlayerModel> _parsePlayers(List<dynamic> data) {
    List<PlayerModel> players = [];
    for (var item in data) {
      players.add(PlayerModel.fromJson(item));
    }
    return players;
  }

  // @Deprecated("use playersGet instead")
  // Future<List<PlayerModel>> getAllPlayers(bool fromRuntimeCache) async {
  //   if (fromRuntimeCache) {
  //     return allPlayersCache;
  //   }

  //   allPlayersCache = await compute<List<Map<String, Object>>, List<PlayerModel>>(
  //     _parsePlayer,
  //     allPlayers,
  //   );
  //   return allPlayersCache;
  // }

  // List<PlayerModel> _parsePlayer(List<Map<String, Object>> data) {
  //   return data.map((e) => PlayerModel.fromJson(e)).toList();
  // }

  // Future<void> savePlayers(List<PlayerModel> players) async {
  //   var box = await Hive.openBox<List<int>>('saved_players_ids');
  //   savedPlayersCache.addAll(players);
  //   savedPlayersCache.toSet().toList();
  //   box.put('players', savedPlayersCache.map((e) => e.id).toList());
  // }

  // Future<List<PlayerModel>> getSavedPlayers(bool fromRuntimeCache) async {
  //   if (fromRuntimeCache) {
  //     return savedPlayersCache;
  //   }

  //   var box = await Hive.openBox<List<int>>('saved_players_ids');
  //   final data = box.get('players', defaultValue: null);
  //   final players = await compute<List<int>?, List<PlayerModel>>(
  //     _parseSavedPlayerIds,
  //     data,
  //   );
  //   savedPlayersCache = players;
  //   return savedPlayersCache;
  // }

  // List<PlayerModel> _parseSavedPlayerIds(List<int>? ids) {
  //   final result = <PlayerModel>[];
  //   for (final id in ids ?? []) {
  //     result.add(PlayerModel.fromJson(allPlayers.firstWhere((player) => player['id'] == id)));
  //   }
  //   return result;
  // }

  Future<List<PlayerModel>> getRandomPlayers(int count) async {
    await _ensurePlayersInitialized();
    final result = <PlayerModel>[];
    while (result.length < count) {
      final player = _getRandomPlayer();
      result.add(player);
    }
    return result;
  }

  PlayerModel _getRandomPlayer() {
    final index = Random().nextInt(allPlayersCache.length);
    return allPlayersCache[index];
  }
}
