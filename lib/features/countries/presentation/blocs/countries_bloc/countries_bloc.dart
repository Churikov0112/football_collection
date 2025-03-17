import 'package:bloc/bloc.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/countries/domain/repos/countries_repository.dart';
import 'package:injectable/injectable.dart';

part 'countries_bloc_event.dart';
part 'countries_bloc_state.dart';

@singleton
class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesRepository _repository;
  CountriesBloc(this._repository) : super(CountriesStateInitial()) {
    on<CountriesEvent>(
      (event, emitter) => switch (event) {
        CountriesEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    CountriesEventGet event,
    Emitter<CountriesState> emit,
  ) async {
    try {
      emit(CountriesStatePending());
      final countries = await _repository.countriesGet(event.regionCode);
      emit(CountriesStateLoadSucceeded(countries));
    } on Object catch (_) {
      emit(CountriesStateFailed('Произошла ошибка'));
    }
  }
}
