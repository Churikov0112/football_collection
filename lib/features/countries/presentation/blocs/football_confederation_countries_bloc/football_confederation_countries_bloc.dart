import 'package:bloc/bloc.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/countries/domain/repos/countries_repository.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:injectable/injectable.dart';

part 'football_confederation_countries_event.dart';
part 'football_confederation_countries_state.dart';

@singleton
class FootballConfederationCountriesBloc
    extends Bloc<FootballConfederationCountriesEvent, FootballConfederationCountriesState> {
  final CountriesRepository _repository;
  FootballConfederationCountriesBloc(this._repository) : super(FootballConfederationCountriesStateInitial()) {
    on<FootballConfederationCountriesEvent>(
      (event, emitter) => switch (event) {
        FootballConfederationCountriesEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    FootballConfederationCountriesEventGet event,
    Emitter<FootballConfederationCountriesState> emit,
  ) async {
    try {
      emit(FootballConfederationCountriesStatePending());
      final countries = await _repository.countriesGet(event.confederation);
      emit(FootballConfederationCountriesStateLoadSucceeded(countries));
    } on Object catch (_) {
      emit(FootballConfederationCountriesStateFailed('Произошла ошибка'));
    }
  }
}
