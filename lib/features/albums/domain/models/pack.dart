import 'package:equatable/equatable.dart';
import 'package:football_collection/features/albums/domain/models/player.dart';

class PackModel extends Equatable {
  final String title;
  final bool isFree;
  final List<PlayerModel>? players;

  const PackModel({
    required this.title,
    required this.isFree,
    required this.players,
  });

  @override
  List<Object?> get props => [title];
}
