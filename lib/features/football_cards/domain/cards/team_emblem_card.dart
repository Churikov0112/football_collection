import 'package:football_collection/features/abstract/domain/models/card.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';

class FootballTeamEmblemCardModel extends CardModel {
  @override
  final String? teamId;

  @override
  final String name;

  const FootballTeamEmblemCardModel({
    required super.cardId,
    required super.imageAssetPath,
    super.cardType = CardType.emblem,
    required this.teamId,
    required this.name,
  });

  factory FootballTeamEmblemCardModel.fromTeam(FootballNationalTeamModel team) {
    return FootballTeamEmblemCardModel(
      cardId: "football_emblem-${team.id}",
      imageAssetPath: "assets/raster/teams_emblems/${team.id}.png",

      teamId: team.id,
      name: team.name,
    );
  }

  @override
  List<Object?> get props => [cardId];
}
