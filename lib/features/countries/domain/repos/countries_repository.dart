import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

@singleton
class CountriesRepository {
  Future<List<CountryModel>> countriesGet(Confederations confederation) async {
    String jsonString = await rootBundle.loadString('assets/json/teams_data.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData
        .map((json) => CountryModel.fromJson(json))
        .where((country) => country.confederation == confederation)
        .toList();
  }
}
