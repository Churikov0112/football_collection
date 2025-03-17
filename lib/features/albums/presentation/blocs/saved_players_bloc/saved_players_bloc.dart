import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/player.dart';

part 'saved_players_event.dart';
part 'saved_players_state.dart';

@singleton
class SavedPlayersBloc extends HydratedBloc<SavedPlayersEvent, SavedPlayersState> {
  SavedPlayersBloc() : super(SavedPlayersStateInitial()) {
    on<SavedPlayersEvent>((event, emit) async {
      switch (event) {
        case SavedPlayersEventLoad():
          await _load(event, emit);
        case SavedPlayersEventAdd():
          await _add(event, emit);
      }
    });
  }

  Future<void> _add(SavedPlayersEventAdd event, Emitter emit) async {
    try {
      final savedPlayersCopy = <PlayerModel>[...(state.savedPlayers ?? [])];
      emit(SavedPlayersStatePending());
      savedPlayersCopy.addAll(event.players);
      emit(SavedPlayersStateLoadSucceeded(players: savedPlayersCopy));
    } catch (e) {
      emit(SavedPlayersStateFailed(message: e.toString()));
    }
  }

  Future<void> _load(SavedPlayersEventLoad event, Emitter emit) async {
    try {
      final savedPlayersCopy = <PlayerModel>[...(state.savedPlayers ?? [])];
      emit(SavedPlayersStatePending());
      emit(SavedPlayersStateLoadSucceeded(players: savedPlayersCopy));
    } catch (e) {
      emit(SavedPlayersStateFailed(message: e.toString()));
    }
  }

  @override
  SavedPlayersState fromJson(Map<String, dynamic>? json) {
    if (json?['savedPlayers'] != null) {
      return SavedPlayersStateLoadSucceeded(
          players: json?['savedPlayers'].map((e) => PlayerModel.fromJson(e)).toList());
    } else {
      return SavedPlayersStateInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(SavedPlayersState state) {
    return switch (state) {
      SavedPlayersStateLoadSucceeded() => <String, dynamic>{
          'savedPlayers': state.players.map((e) => e.toJson()).toList()
        },
      _ => null,
    };
  }
}
