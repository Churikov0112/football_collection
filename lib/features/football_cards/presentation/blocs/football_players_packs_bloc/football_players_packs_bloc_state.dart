part of 'football_players_packs_bloc.dart';

sealed class FootballPlayersPacksState {
  List<PackModel>? get packs {
    return switch (this) {
      FootballPlayersPacksStateLoadSucceeded() => (this as FootballPlayersPacksStateLoadSucceeded)._packs,
      _ => null,
    };
  }
}

final class FootballPlayersPacksStateInitial extends FootballPlayersPacksState {
  FootballPlayersPacksStateInitial();
}

final class FootballPlayersPacksStatePending extends FootballPlayersPacksState {
  FootballPlayersPacksStatePending();
}

final class FootballPlayersPacksStateLoadSucceeded extends FootballPlayersPacksState {
  final List<PackModel> _packs;
  FootballPlayersPacksStateLoadSucceeded(this._packs);
}

final class FootballPlayersPacksStateFailed extends FootballPlayersPacksState {
  final String reason;
  FootballPlayersPacksStateFailed(this.reason);
}
