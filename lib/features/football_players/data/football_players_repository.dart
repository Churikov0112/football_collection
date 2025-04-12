import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/features/abstract/domain/repos/cards_repository.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

import '../../football_confederations/domain/models/football_confederation.dart';
import '../domain/models/player.dart';

@singleton
class FootballPlayersRepository extends CardsRepository {
  List<FootballPlayerModel> allPlayersCache = [];
  List<CountryModel> allTeamsCache = [];
  final Random _random = Random();

  List<FootballPlayerModel> _parsePlayers(List<dynamic> data) {
    List<FootballPlayerModel> players = [];
    for (var item in data) {
      players.add(FootballPlayerModel.fromJson(item));
    }
    return players;
  }

  List<CountryModel> _parseTeams(List<dynamic> data) {
    List<CountryModel> countries = [];
    for (var item in data) {
      countries.add(CountryModel.fromJson(item));
    }
    return countries;
  }

  Future<void> _ensureInitialized() async {
    if (allTeamsCache.isEmpty) {
      String jsonString = await rootBundle.loadString('assets/json/teams_data.json');
      List<dynamic> data = jsonDecode(jsonString);
      allTeamsCache = await compute(_parseTeams, data);
    }
    if (allPlayersCache.isEmpty) {
      String jsonString = await rootBundle.loadString('assets/json/players_data.json');
      List<dynamic> data = jsonDecode(jsonString);
      allPlayersCache = await compute(_parsePlayers, data);
    }
  }

  @override
  Future<List<FootballPlayerModel>> cardsGet([String? countryId]) async {
    await _ensureInitialized();
    if (countryId == null) return [...allPlayersCache];
    return [...allPlayersCache].where((player) => player.countryId == countryId).toList();
  }

  Future<List<CountryModel>> countriesGet([List<String>? countryIds]) async {
    await _ensureInitialized();
    if (countryIds == null) return [...allTeamsCache];
    return [...allTeamsCache].where((country) => countryIds.contains(country.id)).toList();
  }

  @override
  Future<List<PackModel>> packsGet({
    FootballConfederations? confederation,
    CountryModel? country,
  }) async {
    final List<PackModel> packs = [
      if (confederation == null && country != null) ...[
        PackModel(
          title: country.name,
          price: 100,
          cards: await getRandomCards(country: country),
          imageAssetPath: "assets/raster/packs/pack-general.png",
          glbAssetPath: "assets/3d/pack-general.glb",
        ),
        PackModel(
          title: country.confederation.name,
          price: 5,
          cards: await getRandomCards(confederation: country.confederation),
          imageAssetPath: "assets/raster/packs/pack-${country.confederation.name}.png",
          glbAssetPath: "assets/3d/pack-${country.confederation.name}.glb",
        ),
      ],
      if (confederation != null && country == null)
        if (confederation != FootballConfederations.unknown)
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
  Future<List<FootballPlayerModel>> getRandomCards({
    int count = 5,
    CountryModel? country,
    FootballConfederations? confederation,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
    bool? topCountries,
  }) async {
    await _ensureInitialized();
    final result = <FootballPlayerModel>[];
    while (result.length < count) {
      final player = await _getRandomCard(
        country: country,
        confederation: confederation,
        minPrimeTransferValue: minPrimeTransferValue,
        minCurrentTransferValue: minCurrentTransferValue,
        topCountries: topCountries,
      );
      result.add(player);
    }
    return result;
  }

  Future<FootballPlayerModel> _getRandomCard({
    CountryModel? country,
    FootballConfederations? confederation,
    bool? topCountries,
    int? minPrimeTransferValue,
    int? minCurrentTransferValue,
  }) async {
    final playersSublist = allPlayersCache.where((player) {
      if (country != null) {
        if (player.countryId != country.id) return false;
      }
      if (confederation != null) {
        final playerCountryName = allTeamsCache.firstWhere((team) => team.id == player.countryId).name;
        if (confederation != footballConfederationFromCountryName(playerCountryName)) return false;
      }
      if (minPrimeTransferValue != null || minCurrentTransferValue != null) {
        if (minPrimeTransferValue != null && player.maxMarketValue == null) return false;
        if (minCurrentTransferValue != null && player.currentMarketValue == null) return false;
        if (minPrimeTransferValue != null && player.maxMarketValue! < minPrimeTransferValue) return false;
        if (minCurrentTransferValue != null && player.currentMarketValue! < minCurrentTransferValue) return false;
      }
      if (topCountries == true) {
        final top25Countries = allTeamsCache.sublist(0, 25);
        if (!top25Countries.contains(allTeamsCache.firstWhere((team) => team.id == player.countryId))) return false;
      }
      return true;
    }).toList();

    final index = _random.nextInt(playersSublist.length);
    return playersSublist[index];
  }
}
