part of 'saved_players_bloc.dart';

sealed class SavedPlayersEvent {}

class SavedPlayersEventAdd extends SavedPlayersEvent {
  final PlayerModel player;

  SavedPlayersEventAdd({
    required this.player,
  });
}

// class SavedPlayersEventLoad extends SavedPlayersEvent {
//   final bool fromRuntimeCache;

//   SavedPlayersEventLoad({
//     this.fromRuntimeCache = false,
//   });
// }
