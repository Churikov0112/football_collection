import 'package:equatable/equatable.dart';

enum CardType { player, coach, squad, flag }

abstract class CardModel extends Equatable {
  final String cardId;
  final String imageAssetPath;
  final CardType cardType;

  const CardModel({required this.cardId, required this.imageAssetPath, required this.cardType});

  // Добавляем общие методы, которые должны быть у всех карт
  String? get teamId;

  @override
  List<Object?> get props => [cardId];
}
