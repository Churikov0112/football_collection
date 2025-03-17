import 'package:bloc/bloc.dart';
import 'package:football_collection/features/regions/domain/models/region.dart';
import 'package:football_collection/features/regions/domain/repos/regions_repository.dart';
import 'package:injectable/injectable.dart';

part 'regions_bloc_event.dart';
part 'regions_bloc_state.dart';

@singleton
class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  final RegionsRepository _repository;

  RegionsBloc(this._repository) : super(RegionsStateInitial()) {
    on<RegionsEvent>(
      (event, emitter) => switch (event) {
        RegionsEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    RegionsEventGet event,
    Emitter<RegionsState> emit,
  ) async {
    try {
      emit(RegionsStatePending());
      final regions = await _repository.regionsGet();
      emit(RegionsStateLoadSucceeded(regions));
    } on Object catch (_) {
      emit(RegionsStateFailed('Произошла ошибка'));
    }
  }
}
