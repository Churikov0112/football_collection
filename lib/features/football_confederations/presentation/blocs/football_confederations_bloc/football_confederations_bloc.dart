import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/football_confederation.dart';
import '../../../domain/repos/football_confederations_repository.dart';

part 'football_confederations_event.dart';
part 'football_confederations_state.dart';

@singleton
class FootballConfederationsBloc extends Bloc<FootballConfederationsEvent, FootballConfederationsState> {
  final FootballConfederationsRepository _repository;

  FootballConfederationsBloc(this._repository) : super(FootballConfederationsStateInitial()) {
    on<FootballConfederationsEvent>(
      (event, emitter) => switch (event) {
        FootballConfederationsEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    FootballConfederationsEventGet event,
    Emitter<FootballConfederationsState> emit,
  ) async {
    try {
      emit(FootballConfederationsStatePending());
      final confederations = await _repository.footballConfederationsGet();
      emit(FootballConfederationsStateLoadSucceeded(confederations));
    } on Object catch (_) {
      emit(FootballConfederationsStateFailed('Произошла ошибка'));
    }
  }
}
