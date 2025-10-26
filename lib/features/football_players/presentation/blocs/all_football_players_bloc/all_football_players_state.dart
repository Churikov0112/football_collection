part of 'all_football_players_bloc.dart';

sealed class AllFootballPlayersState {
  List<FootballPlayerCardModel>? get allPlayers {
    return switch (this) {
      AllFootballPlayersStateLoadSucceeded() => (this as AllFootballPlayersStateLoadSucceeded).players,
      _ => null,
    };
  }
}

final class AllFootballPlayersStateInitial extends AllFootballPlayersState {}

final class AllFootballPlayersStatePending extends AllFootballPlayersState {}

final class AllFootballPlayersStateLoadSucceeded extends AllFootballPlayersState {
  final List<FootballPlayerCardModel> players;

  AllFootballPlayersStateLoadSucceeded({required this.players});
}

final class AllFootballPlayersStateFailed extends AllFootballPlayersState {
  final String message;

  AllFootballPlayersStateFailed({required this.message});
}
