import '../../../draft/domain/models/team.dart';

class DraftTournamentMatchModel {
  final FootballTeamGameModel? teamA;
  final FootballTeamGameModel? teamB;
  final int? teamAScore;
  final int? teamBScore;

  DraftTournamentMatchModel({
    required this.teamA,
    required this.teamB,
    this.teamAScore,
    this.teamBScore,
  });
}
