import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../models/confederation.dart';

@singleton
class ConnfederationsRepository {
  Future<List<Confederations>> confederationsGet() async {
    String jsonString = await rootBundle.loadString('assets/json/teams_data.json');
    List<dynamic> data = jsonDecode(jsonString);
    List<Confederations> confederations = await compute(_parseConfederations, data);
    return confederations;
  }

  List<Confederations> _parseConfederations(List<dynamic> data) {
    Set<Confederations> confederations = {};
    for (var item in data) {
      if (item.containsKey('name')) {
        String countryName = item['name'];
        Confederations confederation = confederationFromCountryName(countryName);
        if (!confederations.contains(confederation)) confederations.add(confederation);
      }
    }
    return confederations.toList();
  }
}
