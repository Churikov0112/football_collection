import 'draft_tournament.dart';
import 'draft_tournament_match.dart';

class DraftTournamentRoundModel {
  final DraftTournamentStage stage;
  final List<DraftTournamentMatchModel> matches;

  DraftTournamentRoundModel({
    required this.stage,
    required this.matches,
  });
}
