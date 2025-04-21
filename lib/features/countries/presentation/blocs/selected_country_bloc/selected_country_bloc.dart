import 'package:bloc/bloc.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

part 'selected_country_bloc_event.dart';
part 'selected_country_bloc_state.dart';

@singleton
class SelectedCountryBloc extends Bloc<SelectedCountryEvent, SelectedCountryState> {
  SelectedCountryBloc() : super(SelectedCountryStateInitial()) {
    on<SelectedCountryEvent>(
      (event, emitter) => switch (event) {
        SelectedCountryEventSelect() => _select(event, emitter),
        SelectedCountryEventReset() => _reset(event, emitter),
      },
    );
  }

  Future<void> _select(
    SelectedCountryEventSelect event,
    Emitter<SelectedCountryState> emit,
  ) async {
    emit(SelectedCountryStateSelected(event.country));
  }

  Future<void> _reset(
    SelectedCountryEventReset event,
    Emitter<SelectedCountryState> emit,
  ) async {
    emit(SelectedCountryStateInitial());
  }
}
