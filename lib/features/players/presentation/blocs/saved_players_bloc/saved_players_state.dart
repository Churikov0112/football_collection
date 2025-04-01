part of 'saved_players_bloc.dart';

sealed class SavedPlayersState {
  List<String>? get savedIds {
    return switch (this) {
      SavedPlayersStateLoadSucceeded() => (this as SavedPlayersStateLoadSucceeded)._savedIds,
      _ => null,
    };
  }
}

final class SavedPlayersStateInitial extends SavedPlayersState {}

final class SavedPlayersStatePending extends SavedPlayersState {}

final class SavedPlayersStateLoadSucceeded extends SavedPlayersState {
  final List<String> _savedIds;
  SavedPlayersStateLoadSucceeded(this._savedIds);
}

final class SavedPlayersStateFailed extends SavedPlayersState {
  final String message;

  SavedPlayersStateFailed({
    required this.message,
  });
}
