import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'cheat_codes_history_event.dart';
part 'cheat_codes_history_state.dart';

@singleton
class CheatCodesHistoryBloc extends HydratedBloc<CheatCodesHistoryEvent, CheatCodesHistoryState> {
  CheatCodesHistoryBloc() : super(CheatCodesHistoryStateInitial()) {
    on<CheatCodesHistoryEvent>(
      (event, emitter) => switch (event) {
        CheatCodesHistoryEventAdd() => _add(event, emitter),
      },
    );
  }

  Future<void> _add(CheatCodesHistoryEventAdd event, Emitter emit) async {
    try {
      final cheatCodesHistoryCopy = <String>[...(state.history ?? [])];
      cheatCodesHistoryCopy.add(event.code);
      emit(CheatCodesHistoryStateLoadSucceeded(cheatCodesHistoryCopy));
    } catch (e) {
      emit(CheatCodesHistoryStateFailed(message: e.toString()));
    }
  }

  @override
  CheatCodesHistoryState fromJson(Map<String, dynamic> json) {
    try {
      if (json[_kCheatCodesHistoryKey] != null) {
        final List<String> history = json[_kCheatCodesHistoryKey];
        return CheatCodesHistoryStateLoadSucceeded(history);
      }
      return CheatCodesHistoryStateInitial();
    } catch (e) {
      return CheatCodesHistoryStateInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(CheatCodesHistoryState state) {
    final json = {_kCheatCodesHistoryKey: state.history};
    return json;
  }
}

const _kCheatCodesHistoryKey = 'cheat_codes_history';
