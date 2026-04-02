import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:injectable/injectable.dart';

import '../../abstract/domain/models/card.dart';
import '../../countries/domain/models/national_team.dart';
import '../../football_confederations/domain/models/football_confederation.dart';
import '../domain/cards/coach_card.dart';
import '../domain/cards/player_card.dart';

@singleton
class CommonFootballRepository {
  List<FootballConfederations> _allConfederationCache = [];
  List<FootballNationalTeamModel> _allTeamsCache = [];
  List<FootballPlayerCardModel> _allPlayersCache = [];
  List<FootballCoachCardModel> _allCoachesCache = [];
  // List<FootballClubModel> _allClubsCache = [];

  final Random _random = Random();

  List<FootballConfederations> _parseConfederations(List<dynamic> teamsData) {
    Set<FootballConfederations> confederations = {};
    for (var team in teamsData) {
      if (team.containsKey('name')) {
        String countryName = team['name'];
        FootballConfederations confederation = footballConfederationFromCountryName(countryName);
        if (!confederations.contains(confederation)) confederations.add(confederation);
      }
    }
    return confederations.toList();
  }

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

  List<FootballCoachCardModel> _parseCoaches(List<dynamic> data) {
    final List<FootballCoachCardModel> coaches = [];
    for (final item in data) {
      coaches.add(FootballCoachCardModel.fromJson(item));
    }
    return coaches;
  }

  Future<void> _ensureInitialized() async {
    if (_allTeamsCache.isEmpty || _allPlayersCache.isEmpty) {
      final String teamsJson = await rootBundle.loadString('assets/json/prepared_tm_teams.json');
      final List<dynamic> teamsData = jsonDecode(teamsJson);

      // final String clubsJson = await rootBundle.loadString('assets/json/prepared_tm_clubs.json');
      // final List<dynamic> clubsData = jsonDecode(clubsJson);

      final String playersJson = await rootBundle.loadString('assets/json/prepared_tm_players_profiles.json');
      final List<dynamic> playersData = jsonDecode(playersJson);

      final String coachesJson = await rootBundle.loadString('assets/json/prepared_tm_coach_profiles.json');
      final List<dynamic> coachesData = jsonDecode(coachesJson);

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

      try {
        if (_allConfederationCache.isEmpty) {
          _allConfederationCache = await compute(_parseConfederations, teamsData);
        }
      } catch (e) {
        LogService.log(e.toString());
      }

      try {
        if (_allCoachesCache.isEmpty) {
          _allCoachesCache = await compute(_parseCoaches, coachesData);
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

  Future<List<FootballConfederations>> footballConfederationsGet() async {
    await _ensureInitialized();
    return [..._allConfederationCache];
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

  Future<List<FootballCoachCardModel>> coachesGet(FootballNationalTeamModel? team) async {
    await _ensureInitialized();
    return [..._allCoachesCache].where((c) => c.teamId == team?.id).toList();
  }

  Future<List<PackModel>> packsGet({FootballConfederations? confederation, FootballNationalTeamModel? team}) async {
    final List<PackModel> packs = [
      if (team != null)
        PackModel(
          type: .team,
          title: team.name,
          price: 100,
          cards: await getRandomCards(team: team, cardTypes: CardType.values.toSet()),
          // imageAssetPath: "assets/raster/packs/pack-general.png",
          // glbAssetPath: "assets/3d/pack-general.glb",
          imageAssetPath: "assets/raster/packs/countrypackwc26.png",
          glbAssetPath: "assets/3d/countrywc26.glb",
        ),
      if (confederation != null && confederation != FootballConfederations.unknown)
        PackModel(
          type: .confederation,
          title: confederation.name,
          price: 5,
          cards: await getRandomCards(confederation: confederation, cardTypes: CardType.values.toSet()),
          imageAssetPath: "assets/raster/packs/pack-${confederation.name}.png",
          glbAssetPath: "assets/3d/pack-${confederation.name}.glb",
        ),
      PackModel(
        type: .common,
        title: "World tour",
        price: 0,
        cards: await getRandomCards(cardTypes: CardType.values.toSet()),
        // imageAssetPath: "assets/raster/packs/pack-worldtour.png",
        // glbAssetPath: "assets/3d/pack-worldtour.glb",
        imageAssetPath: "assets/raster/packs/generalpackwc2026.png",
        glbAssetPath: "assets/3d/generalwc26.glb",
      ),
      PackModel(
        type: .topPlayers,
        title: "Top players",
        price: 100,
        cards: await getRandomCards(minPrimeTransferValue: 50000000, cardTypes: CardType.values.toSet()),
        imageAssetPath: "assets/raster/packs/pack-topplayers.png",
        glbAssetPath: "assets/3d/pack-topplayers.glb",
      ),
      PackModel(
        type: .topCountries,
        title: "Top 25 countries",
        price: 25,
        cards: await getRandomCards(topCountries: true, cardTypes: CardType.values.toSet()),
        imageAssetPath: "assets/raster/packs/pack-topcountries.png",
        glbAssetPath: "assets/3d/pack-topcountries.glb",
      ),
      if (confederation == null && team == null)
        for (final conf in FootballConfederations.values)
          if (conf != FootballConfederations.unknown)
            PackModel(
              type: .confederation,
              title: conf.name,
              price: 5,
              cards: await getRandomCards(confederation: conf, cardTypes: CardType.values.toSet()),
              imageAssetPath: "assets/raster/packs/pack-${conf.name}.png",
              glbAssetPath: "assets/3d/pack-${conf.name}.glb",
            ),
    ];
    return packs;
  }

  // Общий метод для получения всех карт (игроки + тренеры)
  Future<List<CardModel>> getAllCards({required Set<CardType> cardTypes}) async {
    await _ensureInitialized();
    final List<CardModel> allCards = [..._allPlayersCache, if (cardTypes.contains(CardType.coach)) ..._allCoachesCache];
    return allCards;
  }

  // Фильтрация карт по различным критериям
  Future<List<CardModel>> _filterCards({
    required Set<CardType> cardTypes,
    FootballConfederations? confederation,
    FootballNationalTeamModel? team,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
    bool? topCountries,
  }) async {
    final allCards = await getAllCards(cardTypes: cardTypes);

    return allCards.where((card) {
      // Фильтрация по команде
      if (team != null && card.teamId != team.id) {
        return false;
      }

      // Фильтрация по конфедерации
      if (confederation != null) {
        final cardTeam = _allTeamsCache.firstWhere(
          (t) => t.id == card.teamId,
          orElse: () => throw Exception('Team not found for card: ${card.cardId}'),
        );
        if (cardTeam.confederation != confederation) {
          return false;
        }
      }

      // Фильтрация по топ-странам
      if (topCountries == true) {
        final top8Teams = _allTeamsCache.sublist(0, 8);
        final cardTeam = _allTeamsCache.firstWhere(
          (t) => t.id == card.teamId,
          orElse: () => throw Exception('Team not found for card: ${card.cardId}'),
        );
        if (!top8Teams.contains(cardTeam)) {
          return false;
        }
      }

      // Фильтрация для игроков (по трансферной стоимости)
      if (card is FootballPlayerCardModel) {
        if (minPrimeTransferValue != null && card.maxMarketValue == null) {
          return false;
        }
        if (minCurrentTransferValue != null && card.marketValue == null) {
          return false;
        }
        if (minPrimeTransferValue != null && card.maxMarketValue! < minPrimeTransferValue) {
          return false;
        }
        if (minCurrentTransferValue != null && card.marketValue! < minCurrentTransferValue) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  // Обновленный метод для получения случайных карт
  Future<List<CardModel>> getRandomCards({
    required Set<CardType> cardTypes,
    int count = 5,
    FootballConfederations? confederation,
    FootballNationalTeamModel? team,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
    bool? topCountries,
    bool unique = false,
  }) async {
    await _ensureInitialized();
    final result = <CardModel>[];

    try {
      // Получаем все доступные карты с учетом фильтров
      List<CardModel> availableCards = await _filterCards(
        confederation: confederation,
        team: team,
        minPrimeTransferValue: minPrimeTransferValue,
        minCurrentTransferValue: minCurrentTransferValue,
        topCountries: topCountries,
        cardTypes: cardTypes,
      );

      if (availableCards.isEmpty) {
        return result;
      }

      // Если запрошено больше карт, чем доступно, возвращаем все доступные
      if (availableCards.length <= count) {
        return availableCards;
      }

      // Случайный выбор карт
      while (result.length < count) {
        final index = _random.nextInt(availableCards.length);
        final card = availableCards[index];

        if (unique && result.contains(card)) {
          continue;
        }

        result.add(card);
      }
    } catch (e) {
      LogService.log(e.toString());
    }

    return result;
  }

  // Future<FootballPlayerCardModel?> _randomPlayerGet({
  //   FootballConfederations? confederation,
  //   FootballNationalTeamModel? team,
  //   bool? topCountries,
  //   int? minPrimeTransferValue,
  //   int? minCurrentTransferValue,
  // }) async {
  //   try {
  //     final playersSublist = _allPlayersCache.where((player) {
  //       if (team != null) {
  //         if (player.teamId != team.id) {
  //           return false;
  //         }
  //       }
  //       if (confederation != null) {
  //         if (_allTeamsCache.firstWhere((team) => team.id == player.teamId).confederation != confederation) {
  //           return false;
  //         }
  //       }
  //       if (minPrimeTransferValue != null || minCurrentTransferValue != null) {
  //         if (minPrimeTransferValue != null && player.maxMarketValue == null) {
  //           return false;
  //         }
  //         if (minCurrentTransferValue != null && player.marketValue == null) {
  //           return false;
  //         }
  //         if (minPrimeTransferValue != null && player.maxMarketValue! < minPrimeTransferValue) {
  //           return false;
  //         }
  //         if (minCurrentTransferValue != null && player.marketValue! < minCurrentTransferValue) {
  //           return false;
  //         }
  //       }
  //       if (topCountries == true) {
  //         final top8Teams = _allTeamsCache.sublist(0, 8);
  //         if (!top8Teams.contains(_allTeamsCache.firstWhere((team) => team.id == player.teamId))) {
  //           return false;
  //         }
  //       }
  //       return true;
  //     }).toList();

  //     final index = _random.nextInt(playersSublist.length);
  //     return playersSublist[index];
  //   } catch (e) {
  //     // LogService.log(e.toString());
  //   }
  //   return null;
  // }

  // Future<List<FootballPlayerCardModel>> getRandomPlayers({
  //   int count = 5,
  //   FootballConfederations? confederation,
  //   FootballNationalTeamModel? team,
  //   int? minPrimeTransferValue,
  //   int? minCurrentTransferValue,
  //   bool? topCountries,
  //   bool unique = false,
  // }) async {
  //   await _ensureInitialized();
  //   final result = <FootballPlayerCardModel>[];
  //   try {
  //     while (result.length < count) {
  //       final player = await _randomPlayerGet(
  //         team: team,
  //         confederation: confederation,
  //         minPrimeTransferValue: minPrimeTransferValue,
  //         minCurrentTransferValue: minCurrentTransferValue,
  //         topCountries: topCountries,
  //       );
  //       if (player == null || (unique && result.contains(player))) {
  //         continue;
  //       }
  //       result.add(player);
  //     }
  //   } catch (e) {
  //     LogService.log(e.toString());
  //   }

  //   return result;
  // }
}
