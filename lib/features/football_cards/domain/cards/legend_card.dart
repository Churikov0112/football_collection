// player_card.dart
import 'package:football_collection/features/abstract/domain/models/card.dart';

class FootballLegendCardModel extends CardModel {
  final String playerId;

  @override
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
  final List<String>? citizenship;

  const FootballLegendCardModel({
    required super.cardId,
    required super.imageAssetPath,
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
    required this.citizenship,
    super.cardType = CardType.legend,
  });

  factory FootballLegendCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballLegendCardModel(
      cardId: "${CardType.legend.name}_${json['id']}",
      imageAssetPath: "assets/raster/legends_faces/${json['id']}.jpg",
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
      citizenship: (json['citizenship'] is List)
          ? [for (final citizenship in json['citizenship']) citizenship.toString()]
          : null,
    );
  }

  @override
  List<Object?> get props => [cardId, playerId];
}
