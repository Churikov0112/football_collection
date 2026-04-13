part of 'random_football_players_bloc.dart';

sealed class RandomFootballPlayersState {
  List<FootballPlayerCardModel>? get players {
    return switch (this) {
      RandomFootballPlayersStateLoadSucceeded() =>
        (this as RandomFootballPlayersStateLoadSucceeded)._players,
      _ => null,
    };
  }
}

final class RandomFootballPlayersStateInitial
    extends RandomFootballPlayersState {
  RandomFootballPlayersStateInitial();
}

final class RandomFootballPlayersStatePending
    extends RandomFootballPlayersState {
  RandomFootballPlayersStatePending();
}

final class RandomFootballPlayersStateLoadSucceeded
    extends RandomFootballPlayersState {
  final List<FootballPlayerCardModel> _players;
  RandomFootballPlayersStateLoadSucceeded(this._players);
}

final class RandomFootballPlayersStateFailed
    extends RandomFootballPlayersState {
  final String reason;
  RandomFootballPlayersStateFailed(this.reason);
}
