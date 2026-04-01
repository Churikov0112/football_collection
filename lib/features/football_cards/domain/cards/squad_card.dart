import 'package:football_collection/features/abstract/domain/models/card.dart';

class FootballSquadCardModel extends CardModel {
  @override
  final String? teamId;

  final String? teamName;

  @override
  final String name;

  const FootballSquadCardModel({
    required super.cardId,
    required super.imageAssetPath,
    super.cardType = CardType.squad,
    required this.teamId,
    required this.teamName,
    required this.name,
  });

  factory FootballSquadCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballSquadCardModel(
      cardId: "football_squad-${json['team_id']}",
      imageAssetPath: "assets/raster/coach_faces/${json['id']}.jpg",
      teamId: json['team_id'],
      teamName: json['team_name'],
      name: json['team_name'],
    );
  }

  @override
  List<Object?> get props => [cardId];
}
