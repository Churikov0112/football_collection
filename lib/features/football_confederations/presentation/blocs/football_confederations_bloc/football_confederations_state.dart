part of 'football_confederations_bloc.dart';

sealed class FootballConfederationsState {
  List<FootballConfederations>? get confederations {
    return switch (this) {
      FootballConfederationsStateLoadSucceeded() => (this as FootballConfederationsStateLoadSucceeded)._confederations,
      _ => null,
    };
  }
}

final class FootballConfederationsStateInitial extends FootballConfederationsState {
  FootballConfederationsStateInitial();
}

final class FootballConfederationsStatePending extends FootballConfederationsState {
  FootballConfederationsStatePending();
}

final class FootballConfederationsStateLoadSucceeded extends FootballConfederationsState {
  final List<FootballConfederations> _confederations;
  FootballConfederationsStateLoadSucceeded(this._confederations);
}

final class FootballConfederationsStateFailed extends FootballConfederationsState {
  final String reason;
  FootballConfederationsStateFailed(this.reason);
}
