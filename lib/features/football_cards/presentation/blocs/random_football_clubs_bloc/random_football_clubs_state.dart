part of 'random_football_clubs_bloc.dart';

sealed class RandomFootballClubsState {
  List<FootballClubModel>? get value {
    return switch (this) {
      RandomFootballClubsStateLoadSucceeded() => (this as RandomFootballClubsStateLoadSucceeded)._value,
      _ => null,
    };
  }
}

final class RandomFootballClubsStateInitial extends RandomFootballClubsState {
  RandomFootballClubsStateInitial();
}

final class RandomFootballClubsStatePending extends RandomFootballClubsState {
  RandomFootballClubsStatePending();
}

final class RandomFootballClubsStateLoadSucceeded extends RandomFootballClubsState {
  final List<FootballClubModel> _value;
  RandomFootballClubsStateLoadSucceeded(this._value);
}

final class RandomFootballClubsStateFailed extends RandomFootballClubsState {
  final String reason;
  RandomFootballClubsStateFailed(this.reason);
}
