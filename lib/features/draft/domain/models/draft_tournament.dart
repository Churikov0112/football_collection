import '../../../draft/domain/models/team.dart';
import 'draft_tournament_round.dart';

enum DraftTournamentStage {
  roundOf16, // 1/8
  quarterfinal, // 1/4
  semifinal, // 1/2
  $final, // final
}

extension DraftTournamentStageExtension on DraftTournamentStage {
  String get name {
    switch (this) {
      case DraftTournamentStage.roundOf16:
        return '1/8';
      case DraftTournamentStage.quarterfinal:
        return '1/4';
      case DraftTournamentStage.semifinal:
        return '1/2';
      case DraftTournamentStage.$final:
        return 'Final';
    }
  }
}

class DraftTournamentModel {
  final String name;
  final List<DraftTournamentRoundModel> allRounds;

  DraftTournamentModel({
    required this.name,
    required this.allRounds,
  });

  List<FootballTeamGameModel> get allTeams {
    final allTeams = <FootballTeamGameModel>[];
    final firstRound = allRounds.firstOrNull;
    for (final match in firstRound?.matches ?? []) {
      allTeams.add(match.teamA!);
      allTeams.add(match.teamB!);
    }
    return allTeams;
  }
}
