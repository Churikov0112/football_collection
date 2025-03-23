import 'package:bloc/bloc.dart';
import 'package:football_collection/features/albums/data/players_repository.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

part 'all_countries_bloc_event.dart';
part 'all_countries_bloc_state.dart';

@singleton
class AllCountriesBloc extends Bloc<AllCountriesEvent, AllCountriesState> {
  final PlayersRepository _repository;
  AllCountriesBloc(this._repository) : super(AllCountriesStateInitial()) {
    on<AllCountriesEvent>(
      (event, emitter) => switch (event) {
        AllCountriesEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    AllCountriesEventGet event,
    Emitter<AllCountriesState> emit,
  ) async {
    try {
      emit(AllCountriesStatePending());
      final countries = await _repository.countriesGet();
      emit(AllCountriesStateLoadSucceeded(countries));
    } on Object catch (_) {
      emit(AllCountriesStateFailed('Произошла ошибка'));
    }
  }
}
