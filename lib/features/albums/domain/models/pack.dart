import 'package:equatable/equatable.dart';
import 'package:football_collection/features/albums/domain/models/player.dart';

class PackModel extends Equatable {
  final String title;
  final int price;
  final List<PlayerModel>? players;
  final String? imageAssetPath;

  const PackModel({
    required this.title,
    required this.price,
    required this.players,
    required this.imageAssetPath,
  });

  @override
  List<Object?> get props => [title];
}
