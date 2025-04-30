import 'package:flutter/material.dart';
import 'package:football_collection/features/abstract/domain/models/card.dart';

class FootballPlayerModel extends CardModel {
  final String playerId;
  final String countryId;
  final String name;
  final String? position;
  final String? birthDate;
  final String? height;
  final String? foot;
  final String? currentClub;
  final int? currentMarketValue;
  final int? maxMarketValue;

  const FootballPlayerModel({
    required super.cardId,
    required super.imageUrl,
    required super.imageAssetPath,
    required this.playerId,
    required this.countryId,
    required this.name,
    required this.position,
    required this.birthDate,
    required this.height,
    required this.foot,
    required this.currentClub,
    required this.currentMarketValue,
    required this.maxMarketValue,
  });

  factory FootballPlayerModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballPlayerModel(
      cardId: "football_player-${json['id']}",
      imageAssetPath: "assets/raster/player_faces/${json['id']}.jpg",
      imageUrl: json['image_url'],
      playerId: json['id'],
      countryId: json['team_id'],
      name: json['name'],
      position: json['position'],
      birthDate: json['birth_date'],
      height: json['height'],
      foot: json['foot'],
      currentClub: json['current_club'],
      currentMarketValue: json['current_market_value'],
      maxMarketValue: json['max_market_value'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'cardId': cardId,
      'player_id': playerId,
      'image_asset_path': imageAssetPath,
      'team_id': countryId,
      'name': name,
      'position': position,
      'birth_date': birthDate,
      'height': height,
      'foot': foot,
      'current_club': currentClub,
      'current_market_value': currentMarketValue,
      'max_market_value': maxMarketValue,
      'image_url': imageUrl,
    };
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
