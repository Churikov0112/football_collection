import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/player.dart';

part 'saved_players_event.dart';
part 'saved_players_state.dart';

@singleton
class SavedPlayersBloc extends HydratedBloc<SavedPlayersEvent, SavedPlayersState> {
  SavedPlayersBloc() : super(SavedPlayersStateInitial()) {
    on<SavedPlayersEvent>(
      (event, emitter) => switch (event) {
        // SavedPlayersEventLoad() => _load(event, emitter),
        SavedPlayersEventAdd() => _add(event, emitter),
      },
    );
  }

  Future<void> _add(SavedPlayersEventAdd event, Emitter emit) async {
    try {
      final savedPlayersCopy = <PlayerModel>[...(state.savedPlayers ?? [])];
      savedPlayersCopy.add(event.player);
      emit(SavedPlayersStateLoadSucceeded(players: savedPlayersCopy));
    } catch (e) {
      emit(SavedPlayersStateFailed(message: e.toString()));
    }
  }

  // Future<void> _load(SavedPlayersEventLoad event, Emitter emit) async {
  //   try {
  //     final savedPlayersCopy = <PlayerModel>[...(state.savedPlayers ?? [])];
  //     emit(SavedPlayersStatePending());
  //     emit(SavedPlayersStateLoadSucceeded(players: savedPlayersCopy));
  //   } catch (e) {
  //     emit(SavedPlayersStateFailed(message: e.toString()));
  //   }
  // }

  // @override
  // SavedPlayersState fromJson(Map<String, dynamic>? json) {
  //   if (json?['savedPlayers'] != null) {
  //     return SavedPlayersStateLoadSucceeded(
  //         players: json?['savedPlayers'].map((e) => PlayerModel.fromJson(e)).toList());
  //   } else {
  //     return SavedPlayersStateInitial();
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(SavedPlayersState state) {
  //   try {
  //     return switch (state) {
  //       SavedPlayersStateLoadSucceeded() => <String, dynamic>{
  //           'savedPlayers': state.players.map((e) => e.toJson()).toList()
  //         },
  //       _ => null,
  //     };
  //   } catch (e) {
  //     ToastService.showToast(title: e.toString());
  //   }
  //   return null;
  // }

  @override
  SavedPlayersState fromJson(Map<String, dynamic> json) {
    try {
      if (json[_kSavedPlayersKey] != null) {
        final List<PlayerModel> players =
            List<PlayerModel>.from(json[_kSavedPlayersKey].map((e) => PlayerModel.fromJson(e)));
        return SavedPlayersStateLoadSucceeded(players: players);
      }
      return SavedPlayersStateInitial();
    } catch (e) {
      return SavedPlayersStateInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(SavedPlayersState state) {
    final json = {
      _kSavedPlayersKey: state.savedPlayers?.map((e) => e.toJson()).toList(),
    };
    return json;
  }
}

const _kSavedPlayersKey = 'savedPlayers';
