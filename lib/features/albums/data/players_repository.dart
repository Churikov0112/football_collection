import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:football_collection/features/albums/domain/models/pack.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

import '../../confederations/domain/models/confederation.dart';
import '../domain/models/player.dart';

@singleton
class PlayersRepository {
  List<PlayerModel> allPlayersCache = [];
  List<CountryModel> allTeamsCache = [];
  final Random _random = Random();

  List<PlayerModel> _parsePlayers(List<dynamic> data) {
    List<PlayerModel> players = [];
    for (var item in data) {
      players.add(PlayerModel.fromJson(item));
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

  Future<List<PlayerModel>> playersGet([String? countryId]) async {
    await _ensureInitialized();
    if (countryId == null) return [...allPlayersCache];
    return [...allPlayersCache].where((player) => player.countryId == countryId).toList();
  }

  Future<List<CountryModel>> countriesGet([List<String>? countryIds]) async {
    await _ensureInitialized();
    if (countryIds == null) return [...allTeamsCache];
    return [...allTeamsCache].where((country) => countryIds.contains(country.id)).toList();
  }

  Future<List<PackModel>> getPacks({
    Confederations? confederation,
    CountryModel? country,
  }) async {
    final List<PackModel> packs = [
      if (confederation == null && country != null) ...[
        PackModel(
          title: country.name,
          price: 100,
          players: await getRandomPlayers(country: country),
          imageAssetPath: "assets/raster/packs/pack-general.png",
          glbAssetPath: "assets/3d/pack-general.gif",
        ),
        PackModel(
          title: country.confederation.name,
          price: 5,
          players: await getRandomPlayers(confederation: country.confederation),
          imageAssetPath: "assets/raster/packs/pack-${country.confederation.name}.png",
          glbAssetPath: "assets/3d/pack-${country.confederation.name}.glb",
        ),
      ],
      if (confederation != null && country == null)
        if (confederation != Confederations.unknown)
          PackModel(
            title: confederation.name,
            price: 5,
            players: await getRandomPlayers(confederation: confederation),
            imageAssetPath: "assets/raster/packs/pack-${confederation.name}.png",
            glbAssetPath: "assets/3d/pack-${confederation.name}.glb",
          ),
      PackModel(
        title: "World tour",
        price: 0,
        players: await getRandomPlayers(),
        imageAssetPath: "assets/raster/packs/pack-worldtour.png",
        glbAssetPath: "assets/3d/pack-worldtour.glb",
      ),
      if (confederation == null && country == null)
        for (final conf in Confederations.values)
          if (conf != Confederations.unknown)
            PackModel(
              title: conf.name,
              price: 5,
              players: await getRandomPlayers(confederation: conf),
              imageAssetPath: "assets/raster/packs/pack-${conf.name}.png",
              glbAssetPath: "assets/3d/pack-${conf.name}.glb",
            ),
      PackModel(
          title: "Top 25 countries",
          price: 25,
          players: await getRandomPlayers(topCountries: true),
          imageAssetPath: "assets/raster/packs/pack-topcountries.png",
          glbAssetPath: "assets/3d/pack-topcountries.glb"),
      PackModel(
          title: "Top players",
          price: 100,
          players: await getRandomPlayers(topPlayers: true),
          imageAssetPath: "assets/raster/packs/pack-topplayers.png",
          glbAssetPath: "assets/3d/pack-topplayers.glb"),
    ];
    return packs;
  }

  Future<List<PlayerModel>> getRandomPlayers({
    int count = 5,
    CountryModel? country,
    Confederations? confederation,
    bool? topPlayers,
    bool? topCountries,
    bool? hasCurrentTransferValue,
  }) async {
    await _ensureInitialized();
    final result = <PlayerModel>[];
    while (result.length < count) {
      final player = await _getRandomPlayer(
        country: country,
        confederation: confederation,
        topPlayers: topPlayers,
        topCountries: topCountries,
        hasCurrentTransferValue: hasCurrentTransferValue,
      );
      result.add(player);
    }
    return result;
  }

  Future<PlayerModel> _getRandomPlayer({
    CountryModel? country,
    Confederations? confederation,
    bool? topPlayers,
    bool? topCountries,
    bool? hasCurrentTransferValue,
  }) async {
    final playersSublist = allPlayersCache.where((player) {
      if (hasCurrentTransferValue != null) {
        if (hasCurrentTransferValue == true) {
          if (player.currentMarketValue == null) return false;
        } else {
          if (player.currentMarketValue != null) return false;
        }
      }
      if (country != null) {
        return player.countryId == country.id;
      }
      if (confederation != null) {
        final playerCountryName = allTeamsCache.firstWhere((team) => team.id == player.countryId).name;
        return confederation == confederationFromCountryName(playerCountryName);
      }
      if (topPlayers == true) {
        if (player.maxMarketValue == null) return false;
        return player.maxMarketValue! > 50000000;
      }

      if (topCountries == true) {
        final top25Countries = allTeamsCache.sublist(0, 25);
        return top25Countries.contains(allTeamsCache.firstWhere((team) => team.id == player.countryId));
      }
      return true;
    }).toList();

    final index = _random.nextInt(playersSublist.length);
    return playersSublist[index];
  }
}
