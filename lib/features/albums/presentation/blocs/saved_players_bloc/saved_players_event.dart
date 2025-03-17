part of 'saved_players_bloc.dart';

sealed class SavedPlayersEvent {}

class SavedPlayersEventAdd extends SavedPlayersEvent {
  final List<PlayerModel> players;

  SavedPlayersEventAdd({
    required this.players,
  });
}

class SavedPlayersEventLoad extends SavedPlayersEvent {
  final bool fromRuntimeCache;

  SavedPlayersEventLoad({
    this.fromRuntimeCache = false,
  });
}
