part of 'saved_players_bloc.dart';

sealed class SavedPlayersEvent {}

class SavedPlayersEventAdd extends SavedPlayersEvent {
  final String playerId;

  SavedPlayersEventAdd({
    required this.playerId,
  });
}
