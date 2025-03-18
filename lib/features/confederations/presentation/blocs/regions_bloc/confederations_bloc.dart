import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/confederation.dart';
import '../../../domain/repos/confederations_repository.dart';

part 'confederations_bloc_event.dart';
part 'confederations_bloc_state.dart';

@singleton
class ConfederationsBloc extends Bloc<ConfederationsEvent, ConfederationsState> {
  final ConnfederationsRepository _repository;

  ConfederationsBloc(this._repository) : super(ConfederationsStateInitial()) {
    on<ConfederationsEvent>(
      (event, emitter) => switch (event) {
        ConfederationsEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    ConfederationsEventGet event,
    Emitter<ConfederationsState> emit,
  ) async {
    try {
      emit(ConfederationsStatePending());
      final confederations = await _repository.confederationsGet();
      emit(ConfederationsStateLoadSucceeded(confederations));
    } on Object catch (_) {
      emit(ConfederationsStateFailed('Произошла ошибка'));
    }
  }
}
