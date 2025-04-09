import 'package:equatable/equatable.dart';
import 'package:football_collection/features/abstract/domain/models/card.dart';

class PackModel extends Equatable {
  final String title;
  final int price;
  final List<CardModel>? cards;
  final String imageAssetPath;
  final String glbAssetPath;

  const PackModel({
    required this.title,
    required this.price,
    required this.cards,
    required this.imageAssetPath,
    required this.glbAssetPath,
  });

  @override
  List<Object?> get props => [title];
}
