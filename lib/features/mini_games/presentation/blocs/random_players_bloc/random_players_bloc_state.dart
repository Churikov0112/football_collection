part of 'random_players_bloc.dart';

sealed class RandomPlayersState {
  List<PlayerModel>? get players {
    return switch (this) {
      RandomPlayersStateLoadSucceeded() => (this as RandomPlayersStateLoadSucceeded)._players,
      _ => null,
    };
  }
}

final class RandomPlayersStateInitial extends RandomPlayersState {
  RandomPlayersStateInitial();
}

final class RandomPlayersStatePending extends RandomPlayersState {
  RandomPlayersStatePending();
}

final class RandomPlayersStateLoadSucceeded extends RandomPlayersState {
  final List<PlayerModel> _players;
  RandomPlayersStateLoadSucceeded(this._players);
}

final class RandomPlayersStateFailed extends RandomPlayersState {
  final String reason;
  RandomPlayersStateFailed(this.reason);
}
