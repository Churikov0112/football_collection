import 'package:flutter/material.dart';
import 'package:football_collection/features/abstract/domain/models/card.dart';
import 'package:football_collection/features/football_players/domain/models/market_value.dart';

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
  final int? maxMarketValue;
  final MarketValueModel? marketValue;

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
    required this.maxMarketValue,
    required this.marketValue,
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
      maxMarketValue: json['max_market_value'],
      marketValue: json['market_value'] == null ? null : MarketValueModel.fromJson(json['market_value']),
    );
  }

  @override
  List<Object?> get props => [cardId, playerId];
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

extension FootballPlayerCardModelExtension on FootballPlayerCardModel {
  int? get currentMarketValue => marketValue?.marketValue;
}
