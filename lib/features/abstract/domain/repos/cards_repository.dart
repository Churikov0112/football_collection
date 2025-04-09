import 'package:football_collection/features/abstract/domain/models/pack.dart';

import '../models/card.dart';

abstract class CardsRepository {
  Future<List<CardModel>> cardsGet();
  Future<List<PackModel>> packsGet();
  Future<List<CardModel>> getRandomCards({int count = 5});
}
