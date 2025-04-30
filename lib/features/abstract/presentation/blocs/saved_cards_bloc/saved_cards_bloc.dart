import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'saved_cards_event.dart';
part 'saved_cards_state.dart';

@singleton
class SavedCardsBloc extends HydratedBloc<SavedCardsEvent, SavedCardsState> {
  SavedCardsBloc() : super(SavedCardsStateInitial()) {
    on<SavedCardsEvent>(
      (event, emitter) => switch (event) {
        SavedCardsEventAdd() => _add(event, emitter),
        SavedCardsEventAddAll() => _addAll(event, emitter),
        SavedCardsEventRemove() => _remove(event, emitter),
        SavedCardsEventRemoveAll() => _removeAll(event, emitter),
      },
    );
  }

  Future<void> _add(SavedCardsEventAdd event, Emitter emit) async {
    try {
      final savedCardsIdsCopy = <String>[...(state.savedCardsIds ?? [])];
      savedCardsIdsCopy.add(event.cardId);
      emit(SavedCardsStateLoadSucceeded(savedCardsIdsCopy));
    } catch (e) {
      emit(SavedCardsStateFailed(message: e.toString()));
    }
  }

  Future<void> _addAll(SavedCardsEventAddAll event, Emitter emit) async {
    try {
      final savedCardsIdsCopy = <String>[...(state.savedCardsIds ?? [])];
      savedCardsIdsCopy.addAll(event.cardIds);
      emit(SavedCardsStateLoadSucceeded(savedCardsIdsCopy));
    } catch (e) {
      emit(SavedCardsStateFailed(message: e.toString()));
    }
  }

  Future<void> _remove(SavedCardsEventRemove event, Emitter emit) async {
    try {
      final savedCardsIdsCopy = <String>[...(state.savedCardsIds ?? [])];
      savedCardsIdsCopy.remove(event.cardId);
      emit(SavedCardsStateLoadSucceeded(savedCardsIdsCopy));
    } catch (e) {
      emit(SavedCardsStateFailed(message: e.toString()));
    }
  }

  Future<void> _removeAll(SavedCardsEventRemoveAll event, Emitter emit) async {
    try {
      final savedCardsIdsCopy = <String>[...(state.savedCardsIds ?? [])];
      for (final cardId in event.cardIds) {
        if (savedCardsIdsCopy.contains(cardId)) {
          savedCardsIdsCopy.remove(cardId);
        }
      }
      emit(SavedCardsStateLoadSucceeded(savedCardsIdsCopy));
    } catch (e) {
      emit(SavedCardsStateFailed(message: e.toString()));
    }
  }

  @override
  SavedCardsState fromJson(Map<String, dynamic> json) {
    try {
      if (json[_kSavedCardsIdsKey] != null) {
        final List<String> ids = json[_kSavedCardsIdsKey];
        return SavedCardsStateLoadSucceeded(ids);
      }
      return SavedCardsStateInitial();
    } catch (e) {
      return SavedCardsStateInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(SavedCardsState state) {
    final json = {
      _kSavedCardsIdsKey: state.savedCardsIds,
    };
    return json;
  }
}

const _kSavedCardsIdsKey = 'savedCardsIds';
