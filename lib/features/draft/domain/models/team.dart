import 'dart:ui';

import 'player.dart';
import 'schemes.dart';

class FootballTeamGameModel {
  final String id;
  final String name;
  final Color color;

  final FootballScheme scheme;
  final List<FootballPlayerInTeamGameModel> players;
  final String captainId;

  FootballTeamGameModel({
    required this.id,
    required this.name,
    required this.color,
    required this.scheme,
    required this.players,
    required this.captainId,
  });
}
