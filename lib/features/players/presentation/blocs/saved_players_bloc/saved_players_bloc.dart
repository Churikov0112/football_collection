import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'saved_players_event.dart';
part 'saved_players_state.dart';

@singleton
class SavedPlayersBloc extends HydratedBloc<SavedPlayersEvent, SavedPlayersState> {
  SavedPlayersBloc() : super(SavedPlayersStateInitial()) {
    on<SavedPlayersEvent>(
      (event, emitter) => switch (event) {
        SavedPlayersEventAdd() => _add(event, emitter),
        SavedPlayersEventRemove() => _remove(event, emitter),
      },
    );
  }

  Future<void> _add(SavedPlayersEventAdd event, Emitter emit) async {
    try {
      final savedPlayersIdsCopy = <String>[...(state.savedIds ?? [])];
      savedPlayersIdsCopy.add(event.playerId);
      emit(SavedPlayersStateLoadSucceeded(savedPlayersIdsCopy));
    } catch (e) {
      emit(SavedPlayersStateFailed(message: e.toString()));
    }
  }

  Future<void> _remove(SavedPlayersEventRemove event, Emitter emit) async {
    try {
      final savedPlayersIdsCopy = <String>[...(state.savedIds ?? [])];
      savedPlayersIdsCopy.remove(event.playerId);
      emit(SavedPlayersStateLoadSucceeded(savedPlayersIdsCopy));
    } catch (e) {
      emit(SavedPlayersStateFailed(message: e.toString()));
    }
  }

  @override
  SavedPlayersState fromJson(Map<String, dynamic> json) {
    try {
      if (json[_kSavedPlayersIdsKey] != null) {
        final List<String> ids = json[_kSavedPlayersIdsKey];
        return SavedPlayersStateLoadSucceeded(ids);
      }
      return SavedPlayersStateInitial();
    } catch (e) {
      return SavedPlayersStateInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(SavedPlayersState state) {
    final json = {
      _kSavedPlayersIdsKey: state.savedIds,
    };
    return json;
  }
}

const _kSavedPlayersIdsKey = 'savedPlayersIds';
