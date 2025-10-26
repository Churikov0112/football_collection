part of 'draft_tournament_bloc.dart';

sealed class DraftTournamentEvent {}

final class DraftTournamentEventStart extends DraftTournamentEvent {
  final FootballTeamGameModel userTeam;

  DraftTournamentEventStart({
    required this.userTeam,
  });
}

final class DraftTournamentEventNextMatch extends DraftTournamentEvent {
  final DraftTournamentMatchModel playedMatch;

  DraftTournamentEventNextMatch({
    required this.playedMatch,
  });
}

final class DraftTournamentEventReset extends DraftTournamentEvent {}
