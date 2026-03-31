import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:injectable/injectable.dart';

import '../../countries/domain/models/national_team.dart';
import '../../football_confederations/domain/models/football_confederation.dart';
import '../domain/cards/player_card.dart';

@singleton
class CommonFootballRepository {
  List<FootballNationalTeamModel> _allTeamsCache = [];
  List<FootballPlayerCardModel> _allPlayersCache = [];
  // List<FootballClubModel> _allClubsCache = [];

  final Random _random = Random();

  List<FootballNationalTeamModel> _parseTeams(List<dynamic> data) {
    final List<FootballNationalTeamModel> teams = [];
    for (final item in data) {
      teams.add(FootballNationalTeamModel.fromJson(item));
    }
    return teams;
  }

  List<FootballPlayerCardModel> _parsePlayers(List<dynamic> data) {
    try {
      final List<FootballPlayerCardModel> players = [];
      for (final item in data) {
        if (item['id'] == null) {
          print("object");
        }
        players.add(FootballPlayerCardModel.fromJson(item));
      }
      return players;
    } catch (e) {
      LogService.log(e.toString());
      return [];
    }
  }

  // List<FootballClubModel> _parseClubs(List<dynamic> data) {
  //   final List<FootballClubModel> clubs = [];
  //   for (final item in data) {
  //     clubs.add(FootballClubModel.fromJson(item));
  //   }
  //   return clubs;
  // }

  Future<void> _ensureInitialized() async {
    if (_allTeamsCache.isEmpty || _allPlayersCache.isEmpty) {
      final String teamsJson = await rootBundle.loadString('assets/json/prepared_tm_teams.json');
      final List<dynamic> teamsData = jsonDecode(teamsJson);

      // final String clubsJson = await rootBundle.loadString('assets/json/prepared_tm_clubs.json');
      // final List<dynamic> clubsData = jsonDecode(clubsJson);

      final String playersJson = await rootBundle.loadString('assets/json/prepared_tm_players_profiles.json');
      final List<dynamic> playersData = jsonDecode(playersJson);

      try {
        if (_allPlayersCache.isEmpty) {
          _allPlayersCache = await compute(_parsePlayers, playersData);
        }
      } catch (e) {
        LogService.log(e.toString());
      }

      try {
        if (_allTeamsCache.isEmpty) {
          _allTeamsCache = await compute(_parseTeams, teamsData);
        }
      } catch (e) {
        LogService.log(e.toString());
      }
      // try {
      //   if (_allClubsCache.isEmpty) {
      //     _allClubsCache = await compute(_parseClubs, clubsData);
      //   }
      // } catch (e) {
      //   LogService.log(e.toString());
      // }
    }
  }

  Future<List<FootballNationalTeamModel>> teamsGet({FootballConfederations? confederation, String? teamId}) async {
    await _ensureInitialized();
    if (confederation == null && teamId == null) {
      return [..._allTeamsCache];
    }

    if (teamId != null && confederation == null) {
      return [..._allTeamsCache].where((team) => team.id == teamId).toList();
    }

    if (teamId == null && confederation != null) {
      return [..._allTeamsCache].where((team) => team.confederation == confederation).toList();
    }

    return [..._allTeamsCache].where((team) => team.confederation == confederation && team.id == teamId).toList();
  }

  Future<List<FootballPlayerCardModel>> playersGet([String? teamId]) async {
    await _ensureInitialized();
    if (teamId == null) {
      return [..._allPlayersCache];
    }
    return [..._allPlayersCache].where((player) => player.teamId == teamId).toList();
  }

  Future<List<PackModel>> packsGet({FootballConfederations? confederation, FootballNationalTeamModel? team}) async {
    final List<PackModel> packs = [
      if (team != null)
        PackModel(
          title: team.name,
          price: 100,
          cards: await getRandomCards(team: team),
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
      if (confederation == null && team == null)
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

  Future<List<FootballPlayerCardModel>> getRandomCards({
    int count = 5,
    FootballConfederations? confederation,
    FootballNationalTeamModel? team,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
    bool? topCountries,
    bool unique = false,
  }) async {
    await _ensureInitialized();
    final result = <FootballPlayerCardModel>[];
    try {
      while (result.length < count) {
        final player = await _randomPlayerGet(
          team: team,
          confederation: confederation,
          minPrimeTransferValue: minPrimeTransferValue,
          minCurrentTransferValue: minCurrentTransferValue,
          topCountries: topCountries,
        );
        if (player == null || (unique && result.contains(player))) {
          continue;
        }
        result.add(player);
      }
    } catch (e) {
      LogService.log(e.toString());
    }

    return result;
  }

  Future<FootballPlayerCardModel?> _randomPlayerGet({
    FootballConfederations? confederation,
    FootballNationalTeamModel? team,
    bool? topCountries,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
  }) async {
    try {
      final playersSublist = _allPlayersCache.where((player) {
        if (team != null) {
          if (player.teamId != team.id) {
            return false;
          }
        }
        if (confederation != null) {
          if (_allTeamsCache.firstWhere((team) => team.id == player.teamId).confederation != confederation) {
            return false;
          }
        }
        if (minPrimeTransferValue != null || minCurrentTransferValue != null) {
          if (minPrimeTransferValue != null && player.maxMarketValue == null) {
            return false;
          }
          if (minCurrentTransferValue != null && player.marketValue == null) {
            return false;
          }
          if (minPrimeTransferValue != null && player.maxMarketValue! < minPrimeTransferValue) {
            return false;
          }
          if (minCurrentTransferValue != null && player.marketValue! < minCurrentTransferValue) {
            return false;
          }
        }
        if (topCountries == true) {
          final top8Teams = _allTeamsCache.sublist(0, 8);
          if (!top8Teams.contains(_allTeamsCache.firstWhere((team) => team.id == player.teamId))) {
            return false;
          }
        }
        return true;
      }).toList();

      final index = _random.nextInt(playersSublist.length);
      return playersSublist[index];
    } catch (e) {
      // LogService.log(e.toString());
    }
    return null;
  }
}
