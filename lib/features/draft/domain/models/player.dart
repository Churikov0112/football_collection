import 'package:equatable/equatable.dart';

import '../../../football_cards/domain/models/player.dart';
import 'position.dart';
import 'stats.dart';

class FootballPlayerPositionOnField extends Equatable {
  final String id;
  final FootballPlayerAbstractPosition abstractPosition;
  final double x;
  final double y;

  const FootballPlayerPositionOnField(this.id, this.abstractPosition, this.x, this.y);

  @override
  List<Object?> get props => [id];
}

class FootballPlayerInTeamGameModel {
  final String teamId;
  final int number;
  final FootballPlayerPositionOnField pof;
  final FootballPlayerGameModel data;

  FootballPlayerInTeamGameModel({required this.teamId, required this.number, required this.pof, required this.data});
}

class FootballPlayerGameModel {
  final String id;
  final FootballPlayerStats stats;
  final FootballPlayerCardModel card;

  FootballPlayerGameModel({required this.id, required this.stats, required this.card});
}
