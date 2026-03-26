import 'package:flutter/material.dart';
import 'package:football_collection/features/abstract/domain/models/card.dart';

import '../../../../di/di.dart';
import '../../data/football_players_repository.dart';

class FootballPlayerCardModel extends CardModel {
  final String playerId;
  final String name;
  final String? teamId;
  final String? teamName;
  final String? clubId;
  final String? clubName;
  final String? position;
  final String? number;
  final String? birthDate;
  final String? height;
  final String? foot;

  const FootballPlayerCardModel({
    required super.cardId,
    required super.imageAssetPath,
    required this.playerId,
    required this.name,
    required this.position,
    required this.birthDate,
    required this.height,
    required this.foot,

    required this.number,
    required this.clubId,
    required this.teamId,
    required this.teamName,
    required this.clubName,
  });

  factory FootballPlayerCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballPlayerCardModel(
      cardId: "football_player-${json['id']}",
      imageAssetPath: "assets/raster/player_faces/${json['id']}.jpg",
      playerId: json['id'],
      name: json['name'],
      position: json['position'],
      birthDate: json['birth_date'],
      height: json['height'],
      foot: json['foot'],
      number: json['number'],
      clubId: json['club_id'],
      teamId: json['team_id'],
      teamName: json['team_name'],
      clubName: json['club_name'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': playerId,
      'name': name,
      'position': position,
      'birth_date': birthDate,
      'height': height,
      'foot': foot,
      'number': number,
      'club_id': clubId,
      'team_id': teamId,
      'team_name': teamName,
      'club_name': clubName,
    };
  }

  @override
  List<Object?> get props => [cardId, playerId];
}

extension FootballPlayerCardModelExtension on FootballPlayerCardModel {
  int? get maxMarketValue {
    return getIt.get<FootballPlayersRepository>().playerMaxMarketValue(playerId);
  }

  int? get currentMarketValue {
    return getIt.get<FootballPlayersRepository>().playerCurrentMarketValue(playerId);
  }
}

String? footballPlayerPositionToShort(String? position) {
  if (position == null) return null;
  switch (position) {
    case "Goalkeeper":
      return "GK";
    case "Centre-Back":
      return "CB";
    case "Left-Back":
      return "LB";
    case "Right-Back":
      return "RB";
    case "Defensive Midfield":
      return "DM";
    case "Central Midfield":
      return "CM";
    case "Attacking Midfield":
      return "AM";
    case "Left Midfield":
      return "LM";
    case "Right Midfield":
      return "RM";
    case "Left Winger":
      return "LW";
    case "Right Winger":
      return "RW";
    case "Centre-Forward":
      return "CF";
    case "Second Striker":
      return "SS";
    case "Striker":
      return "ST";
    default:
      return null;
  }
}

Color? footballPlayerPositionToColor(String? position) {
  if (position == null) return null;
  switch (position) {
    case "Goalkeeper":
      return Colors.orange;
    case "Centre-Back":
      return Colors.blue;
    case "Left-Back":
      return Colors.blue;
    case "Right-Back":
      return Colors.blue;
    case "Defensive Midfield":
      return Colors.green;
    case "Central Midfield":
      return Colors.green;
    case "Attacking Midfield":
      return Colors.green;
    case "Left Midfield":
      return Colors.green;
    case "Right Midfield":
      return Colors.green;
    case "Left Winger":
      return Colors.red;
    case "Right Winger":
      return Colors.red;
    case "Centre-Forward":
      return Colors.red;
    case "Second Striker":
      return Colors.red;
    case "Striker":
      return Colors.red;
    default:
      return null;
  }
}
