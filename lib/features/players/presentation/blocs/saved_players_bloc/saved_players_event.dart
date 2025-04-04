part of 'saved_players_bloc.dart';

sealed class SavedPlayersEvent {}

class SavedPlayersEventAdd extends SavedPlayersEvent {
  final String playerId;

  SavedPlayersEventAdd({
    required this.playerId,
  });
}

class SavedPlayersEventRemove extends SavedPlayersEvent {
  final String playerId;

  SavedPlayersEventRemove({
    required this.playerId,
  });
}
