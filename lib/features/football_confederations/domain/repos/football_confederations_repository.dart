import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../models/football_confederation.dart';

@singleton
class FootballConfederationsRepository {
  Future<List<FootballConfederations>> footballConfederationsGet() async {
    String jsonString = await rootBundle.loadString('assets/json/prepared_tm_teams.json');
    List<dynamic> data = jsonDecode(jsonString);
    List<FootballConfederations> confederations = await compute(_parseConfederations, data);
    return confederations;
  }

  List<FootballConfederations> _parseConfederations(List<dynamic> data) {
    Set<FootballConfederations> confederations = {};
    for (var item in data) {
      if (item.containsKey('name')) {
        String countryName = item['name'];
        FootballConfederations confederation = footballConfederationFromCountryName(countryName);
        if (!confederations.contains(confederation)) confederations.add(confederation);
      }
    }
    return confederations.toList();
  }
}
