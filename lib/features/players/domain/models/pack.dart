import 'package:equatable/equatable.dart';
import 'package:football_collection/features/players/domain/models/player.dart';

class PackModel extends Equatable {
  final String title;
  final int price;
  final List<PlayerModel>? players;
  final String imageAssetPath;
  final String glbAssetPath;

  const PackModel({
    required this.title,
    required this.price,
    required this.players,
    required this.imageAssetPath,
    required this.glbAssetPath,
  });

  @override
  List<Object?> get props => [title];
}
