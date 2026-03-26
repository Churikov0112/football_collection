import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/features/abstract/domain/repos/cards_repository.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_players/domain/models/club.dart';
import 'package:football_collection/features/football_players/domain/models/market_value.dart';
import 'package:injectable/injectable.dart';

import '../../football_confederations/domain/models/football_confederation.dart';
import '../domain/models/player.dart';

@singleton
class FootballPlayersRepository extends CardsRepository {
  List<FootballPlayerCardModel> allPlayersCache = [];
  List<FootballNationalTeamModel> allTeamsCache = [];
  List<FootballPlayerMarketValueModel> allMarketValuesCache = [];
  List<FootballClubModel> allClubsCache = [];

  final Random _random = Random();

  bool _indicesBuilt = false;
  final Map<String, FootballConfederations> _confederationByTeamId = {};
  final Map<String, List<FootballPlayerCardModel>> _playersByTeamId = {};
  final Map<FootballConfederations, List<FootballPlayerCardModel>> _playersByConfederation = {};
  final Set<String> _top25TeamIds = <String>{};
  final Map<String, int> _playerMaxMarketValueById = {};
  final Map<String, int> _playerCurrentMarketValueById = {};

  List<FootballPlayerCardModel> _parsePlayers(List<dynamic> data) {
    List<FootballPlayerCardModel> players = [];
    for (var item in data) {
      players.add(FootballPlayerCardModel.fromJson(item));
    }
    return players;
  }

  List<FootballNationalTeamModel> _parseTeams(List<dynamic> data) {
    List<FootballNationalTeamModel> countries = [];
    for (var item in data) {
      countries.add(FootballNationalTeamModel.fromJson(item));
    }
    return countries;
  }

  List<FootballPlayerMarketValueModel> _parseMarketValues(List<dynamic> data) {
    List<FootballPlayerMarketValueModel> marketValues = [];
    for (var item in data) {
      marketValues.add(FootballPlayerMarketValueModel.fromJson(item));
    }
    return marketValues;
  }

  List<FootballClubModel> _parseClubs(List<dynamic> data) {
    List<FootballClubModel> clubs = [];
    for (var item in data) {
      clubs.add(FootballClubModel.fromJson(item));
    }
    return clubs;
  }

  Future<void> _ensureInitialized() async {
    try {
      if (allTeamsCache.isEmpty) {
        String jsonString = await rootBundle.loadString('assets/json/teams_data.json');
        List<dynamic> data = jsonDecode(jsonString);
        allTeamsCache = await compute(_parseTeams, data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      if (allPlayersCache.isEmpty) {
        String jsonString = await rootBundle.loadString('assets/json/players_data.json');
        List<dynamic> data = jsonDecode(jsonString);
        allPlayersCache = await compute(_parsePlayers, data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      if (allMarketValuesCache.isEmpty) {
        String jsonString = await rootBundle.loadString('assets/json/market_values_data.json');
        List<dynamic> data = jsonDecode(jsonString);
        allMarketValuesCache = await compute(_parseMarketValues, data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      if (allClubsCache.isEmpty) {
        String jsonString = await rootBundle.loadString('assets/json/clubs_data.json');
        List<dynamic> data = jsonDecode(jsonString);
        allClubsCache = await compute(_parseClubs, data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    _buildIndexesIfNeeded();
  }

  void _buildIndexesIfNeeded() {
    if (_indicesBuilt) {
      final hasMarketValues = allMarketValuesCache.isNotEmpty;
      final marketValuesIndexed = _playerMaxMarketValueById.isNotEmpty || _playerCurrentMarketValueById.isNotEmpty;
      if (!hasMarketValues || marketValuesIndexed) return;
      _indicesBuilt = false;
    }
    if (allPlayersCache.isEmpty || allTeamsCache.isEmpty) return;

    _confederationByTeamId
      ..clear()
      ..addEntries(allTeamsCache.map((team) => MapEntry(team.id, team.confederation)));

    _top25TeamIds
      ..clear()
      ..addAll(allTeamsCache.take(25).map((team) => team.id));

    _playersByTeamId.clear();
    _playersByConfederation.clear();
    for (final player in allPlayersCache) {
      final teamId = player.teamId;
      if (teamId != null) {
        _playersByTeamId.putIfAbsent(teamId, () => <FootballPlayerCardModel>[]).add(player);
        final confederation = _confederationByTeamId[teamId];
        if (confederation != null) {
          _playersByConfederation.putIfAbsent(confederation, () => <FootballPlayerCardModel>[]).add(player);
        }
      }
    }

    _playerMaxMarketValueById.clear();
    _playerCurrentMarketValueById.clear();
    for (final mv in allMarketValuesCache) {
      final history = mv.marketValue?.marketValueHistory ?? const <MarketValueHistoryModel>[];
      int? max;
      for (final mvHistoryItem in history) {
        final value = mvHistoryItem.marketValue;
        if (value != null && (max == null || value > max)) {
          max = value;
        }
      }
      if (max != null) _playerMaxMarketValueById[mv.id] = max;

      final current = mv.marketValue?.marketValue;
      if (current != null) _playerCurrentMarketValueById[mv.id] = current;
    }

    _indicesBuilt = true;
  }

  @override
  Future<List<FootballPlayerCardModel>> cardsGet([String? countryId]) async {
    await _ensureInitialized();
    if (countryId == null) return List<FootballPlayerCardModel>.from(allPlayersCache);
    final cached = _playersByTeamId[countryId];
    if (cached != null) return List<FootballPlayerCardModel>.from(cached);
    return List<FootballPlayerCardModel>.from(
      allPlayersCache.where((player) => player.teamId == countryId),
    );
  }

  Future<List<FootballNationalTeamModel>> countriesGet([List<String>? countryIds]) async {
    await _ensureInitialized();
    if (countryIds == null) return [...allTeamsCache];
    return [...allTeamsCache].where((country) => countryIds.contains(country.id)).toList();
  }

  @override
  Future<List<PackModel>> packsGet({FootballConfederations? confederation, FootballNationalTeamModel? country}) async {
    final List<PackModel> packs = [
      if (country != null)
        PackModel(
          title: country.name,
          price: 100,
          cards: await getRandomCards(country: country),
          imageAssetPath: "assets/raster/packs/pack-general.png",
          glbAssetPath: "assets/3d/pack-general.glb",
        ),
      if (confederation != null && confederation != FootballConfederations.unknown)
        PackModel(
          title: confederation.name,
          price: 5,
          cards: await getRandomCards(confederation: confederation),
          imageAssetPath: "assets/raster/packs/pack-${confederation.name}.png",
          glbAssetPath: "assets/3d/pack-${confederation.name}.glb",
        ),
      PackModel(
        title: "World tour",
        price: 0,
        cards: await getRandomCards(),
        imageAssetPath: "assets/raster/packs/pack-worldtour.png",
        glbAssetPath: "assets/3d/pack-worldtour.glb",
      ),
      PackModel(
        title: "Top players",
        price: 100,
        cards: await getRandomCards(minPrimeTransferValue: 50000000),
        imageAssetPath: "assets/raster/packs/pack-topplayers.png",
        glbAssetPath: "assets/3d/pack-topplayers.glb",
      ),
      PackModel(
        title: "Top 25 countries",
        price: 25,
        cards: await getRandomCards(topCountries: true),
        imageAssetPath: "assets/raster/packs/pack-topcountries.png",
        glbAssetPath: "assets/3d/pack-topcountries.glb",
      ),
      if (confederation == null && country == null)
        for (final conf in FootballConfederations.values)
          if (conf != FootballConfederations.unknown)
            PackModel(
              title: conf.name,
              price: 5,
              cards: await getRandomCards(confederation: conf),
              imageAssetPath: "assets/raster/packs/pack-${conf.name}.png",
              glbAssetPath: "assets/3d/pack-${conf.name}.glb",
            ),
    ];
    return packs;
  }

  @override
  Future<List<FootballPlayerCardModel>> getRandomCards({
    int count = 5,
    FootballNationalTeamModel? country,
    FootballConfederations? confederation,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
    bool? topCountries,
    bool unique = false,
  }) async {
    await _ensureInitialized();
    final candidates = _filterPlayers(
      country: country,
      confederation: confederation,
      minPrimeTransferValue: minPrimeTransferValue,
      minCurrentTransferValue: minCurrentTransferValue,
      topCountries: topCountries,
    );

    if (candidates.isEmpty) {
      throw StateError('No players found for the requested filters');
    }

    if (unique) {
      if (count >= candidates.length) return List<FootballPlayerCardModel>.from(candidates);
      final shuffled = List<FootballPlayerCardModel>.from(candidates);
      shuffled.shuffle(_random);
      return shuffled.take(count).toList();
    }

    final result = <FootballPlayerCardModel>[];
    for (var i = 0; i < count; i++) {
      result.add(candidates[_random.nextInt(candidates.length)]);
    }
    return result;
  }

  int? playerMaxMarketValue(String id) {
    _buildIndexesIfNeeded();
    if (_playerMaxMarketValueById.isNotEmpty) return _playerMaxMarketValueById[id];
    final mv = allMarketValuesCache.firstWhereOrNull((mv) => mv.id == id);

    int? max;
    for (final mvHistoryItem in mv?.marketValue?.marketValueHistory ?? <MarketValueHistoryModel>[]) {
      if ((mvHistoryItem.marketValue ?? 0) > (max ?? 0)) {
        max = mvHistoryItem.marketValue;
      }
    }

    return max;
  }

  int? playerCurrentMarketValue(String id) {
    _buildIndexesIfNeeded();
    if (_playerCurrentMarketValueById.isNotEmpty) return _playerCurrentMarketValueById[id];
    final mv = allMarketValuesCache.firstWhereOrNull((mv) => mv.id == id);
    return mv?.marketValue?.marketValue;
  }

  List<FootballPlayerCardModel> _filterPlayers({
    FootballNationalTeamModel? country,
    FootballConfederations? confederation,
    bool? topCountries,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
  }) {
    Iterable<FootballPlayerCardModel> source = allPlayersCache;
    if (country != null) {
      source = _playersByTeamId[country.id] ?? const <FootballPlayerCardModel>[];
    } else if (confederation != null) {
      source = _playersByConfederation[confederation] ?? const <FootballPlayerCardModel>[];
    }

    if (source.isEmpty) return const <FootballPlayerCardModel>[];

    return source.where((player) {
      if (topCountries == true && !_top25TeamIds.contains(player.teamId)) {
        return false;
      }

      if (minPrimeTransferValue != null) {
        final value = _playerMaxMarketValueById[player.playerId];
        if (value == null || value < minPrimeTransferValue) return false;
      }
      if (minCurrentTransferValue != null) {
        final value = _playerCurrentMarketValueById[player.playerId];
        if (value == null || value < minCurrentTransferValue) return false;
      }

      return true;
    }).toList();
  }
}
