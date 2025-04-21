import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../football_confederations/domain/models/football_confederation.dart';

part 'selected_confederation_bloc_event.dart';
part 'selected_confederation_bloc_state.dart';

@singleton
class SelectedConfederationBloc extends Bloc<SelectedConfederationEvent, SelectedConfederationState> {
  SelectedConfederationBloc() : super(SelectedConfederationStateInitial()) {
    on<SelectedConfederationEvent>(
      (event, emitter) => switch (event) {
        SelectedConfederationEventSelect() => _select(event, emitter),
        SelectedConfederationEventReset() => _reset(event, emitter),
      },
    );
  }

  Future<void> _select(
    SelectedConfederationEventSelect event,
    Emitter<SelectedConfederationState> emit,
  ) async {
    emit(SelectedConfederationStateSelected(event.confederation));
  }

  Future<void> _reset(
    SelectedConfederationEventReset event,
    Emitter<SelectedConfederationState> emit,
  ) async {
    emit(SelectedConfederationStateInitial());
  }
}
