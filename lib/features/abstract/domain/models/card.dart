import 'package:equatable/equatable.dart';

abstract class CardModel extends Equatable {
  final String cardId;
  final String imageAssetPath;
  final String imageUrl;

  const CardModel({
    required this.cardId,
    required this.imageUrl,
    required this.imageAssetPath,
  });

  @override
  List<Object?> get props => [cardId];
}
