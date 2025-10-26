part of 'draft_tournament_bloc.dart';

sealed class DraftTournamentState {
  DraftTournamentModel? get tournament {
    return switch (this) {
      DraftTournamentStateProgress() => (this as DraftTournamentStateProgress)._tournament,
      _ => null,
    };
  }

  DraftTournamentStage? get stage {
    return switch (this) {
      DraftTournamentStateProgress() => (this as DraftTournamentStateProgress)._stage,
      _ => null,
    };
  }
}

final class DraftTournamentStateInitial extends DraftTournamentState {
  DraftTournamentStateInitial();
}

final class DraftTournamentStateProgress extends DraftTournamentState {
  final DraftTournamentModel _tournament;
  final DraftTournamentStage? _stage;
  DraftTournamentStateProgress(this._tournament, this._stage);
}
