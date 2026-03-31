// player_card.dart
import 'package:flutter/material.dart';
import 'package:football_collection/features/abstract/domain/models/card.dart';

class FootballPlayerCardModel extends CardModel {
  final String playerId;

  final String name;

  @override
  final String? teamId;

  final String? teamName;
  final String? teamShirtNumber;
  final String? clubId;
  final String? clubName;
  final String? position;
  final String? birthDate;
  final int? height;
  final String? outfitter;
  final bool? isRetired;
  final String? foot;
  final int? maxMarketValue;
  final int? marketValue;

  const FootballPlayerCardModel({
    required super.cardId,
    required super.imageAssetPath,
    super.cardType = CardType.player,
    required this.playerId,
    required this.name,
    required this.position,
    required this.birthDate,
    required this.height,
    required this.foot,
    required this.clubId,
    required this.clubName,
    required this.teamId,
    required this.teamName,
    required this.teamShirtNumber,
    required this.marketValue,
    required this.maxMarketValue,
    required this.outfitter,
    required this.isRetired,
  });

  factory FootballPlayerCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballPlayerCardModel(
      cardId: "football_player-${json['id']}",
      imageAssetPath: "assets/raster/player_faces/${json['id']}.jpg",
      playerId: json['id'],
      name: json['name'],
      position: json['position']?['main'],
      birthDate: json['birth_date'],
      height: json['height'],
      foot: json['foot'],
      teamShirtNumber: json['team_shirt_number'],
      clubId: json['club_id'],
      teamId: json['team_id'],
      teamName: json['team_name'],
      clubName: json['club_name'],
      maxMarketValue: json['maxMarketValue'],
      marketValue: json['marketValue'],
      outfitter: json['outfitter'],
      isRetired: json['isRetired'],
    );
  }

  @override
  List<Object?> get props => [cardId, playerId];
}

// Вспомогательные функции остаются без изменений
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
