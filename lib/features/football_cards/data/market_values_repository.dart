import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../domain/models/market_value_model.dart';

@singleton
class MarketValuesRepository {
  Future<MarketValueModel?> marketValueGet(String playerId) async {
    final String marketValuesJson = await rootBundle.loadString('assets/json/prepared_tm_players_market_values.json');
    final List<dynamic> marketValuesData = jsonDecode(marketValuesJson);
    final marketValueData = marketValuesData.firstWhereOrNull((mv) => mv['id'] == playerId);
    if (marketValueData == null) {
      return null;
    }
    return MarketValueModel.fromJson(marketValueData);
  }

  final Random _random = Random();

  /// if playerId is null, returns random
  Future<MarketValueModel?> randomMarketValueHistoryGet({int minItems = 2, int? minPrimeValue}) async {
    final String marketValuesJson = await rootBundle.loadString('assets/json/prepared_tm_players_market_values.json');
    final List<dynamic> marketValuesData = jsonDecode(marketValuesJson);

    while (true) {
      final marketValueData = marketValuesData[_random.nextInt(marketValuesData.length)];
      final marketValueHistoryData = marketValueData['marketValueHistory'];

      if (marketValueHistoryData is List && marketValueHistoryData.length >= minItems) {
        if (minPrimeValue != null) {
          int primeValue = 0;
          for (final item in marketValueHistoryData) {
            if ((item['marketValue'] ?? 0) > primeValue) {
              primeValue = item['marketValue'];
            }
          }
          if (primeValue >= minPrimeValue) {
            return MarketValueModel.fromJson(marketValueData);
          }
        }
      }
    }
  }
}
