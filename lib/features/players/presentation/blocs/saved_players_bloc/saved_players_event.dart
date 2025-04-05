part of 'saved_players_bloc.dart';

sealed class SavedPlayersEvent {}

class SavedPlayersEventAdd extends SavedPlayersEvent {
  final String playerId;

  SavedPlayersEventAdd({
    required this.playerId,
  });
}

class SavedPlayersEventAddAll extends SavedPlayersEvent {
  final List<String> playerIds;

  SavedPlayersEventAddAll({
    required this.playerIds,
  });
}

class SavedPlayersEventRemove extends SavedPlayersEvent {
  final String playerId;

  SavedPlayersEventRemove({
    required this.playerId,
  });
}
