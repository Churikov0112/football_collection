import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String cardId;
  final String imageAssetPath;

  const CardModel({required this.cardId, required this.imageAssetPath});

  @override
  List<Object?> get props => [cardId];
}
