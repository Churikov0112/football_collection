import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:football_collection/features/football_cards/domain/models/club_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class FootballClubsRepository {
  final Random _random = Random();

  Future<List<dynamic>> _clubsDataGet() async {
    final String clubsJson = await rootBundle.loadString('assets/json/prepared_tm_clubs.json');
    final List<dynamic> clubsData = jsonDecode(clubsJson);
    return clubsData;
    // return clubsData.map((e) => FootballClubModel.fromJson(e)).toList();
  }

  Future<FootballClubModel?> footballClubGet(String id) async {
    final clubsData = await _clubsDataGet();
    final clubData = clubsData.firstWhereOrNull((c) => c['id'] == id);
    final club = FootballClubModel.fromJson(clubData);
    return club;
  }

  Future<List<FootballClubModel>> randomClubsGet({
    required int count,
    bool? withStadiumName,
    bool? withStadiumSeats,
  }) async {
    final clubsData = await _clubsDataGet();
    final filteredClubsData = clubsData.where((club) {
      if (withStadiumName != null) {
        if (withStadiumName == true && club['stadiumName'] == null) {
          return false;
        }
        if (withStadiumName == false && club['stadiumName'] != null) {
          return false;
        }
      }

      if (withStadiumSeats != null) {
        if (withStadiumSeats == true && club['stadiumSeats'] == null) {
          return false;
        }
        if (withStadiumSeats == false && club['stadiumSeats'] != null) {
          return false;
        }
      }

      return true;
    }).toList();

    final List<FootballClubModel> clubs = [];
    while (clubs.length < count) {
      final clubData = filteredClubsData[_random.nextInt(filteredClubsData.length)];
      if (clubs.firstWhereOrNull((c) => c.id == clubData['id']) == null) {
        final club = FootballClubModel.fromJson(clubData);
        clubs.add(club);
      }
    }
    return clubs;
  }
}
