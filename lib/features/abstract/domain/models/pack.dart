import 'package:equatable/equatable.dart';
import 'package:football_collection/features/abstract/domain/models/card.dart';

enum PackType { common, confederation, topPlayers, topCountries, team }

class PackModel extends Equatable {
  final String title;
  final int price;
  final List<CardModel>? cards;
  final String imageAssetPath;
  final String glbAssetPath;
  final PackType type;

  const PackModel({
    required this.title,
    required this.type,
    required this.price,
    required this.cards,
    required this.imageAssetPath,
    required this.glbAssetPath,
  });

  @override
  List<Object?> get props => [title];
}
