part of 'all_football_players_bloc.dart';

sealed class AllFootballPlayersEvent {}

class AllFootballPlayersEventLoad extends AllFootballPlayersEvent {
  final bool fromRuntimeCache;

  AllFootballPlayersEventLoad({
    this.fromRuntimeCache = false,
  });
}
