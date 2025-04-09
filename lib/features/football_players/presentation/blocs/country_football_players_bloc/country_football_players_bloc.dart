import 'package:bloc/bloc.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

import '../../../data/football_players_repository.dart';
import '../../../domain/models/player.dart';

part 'country_football_players_bloc_event.dart';
part 'country_football_players_bloc_state.dart';

@singleton
class CountryFootballPlayersBloc extends Bloc<CountryFootballPlayersEvent, CountryFootballPlayersState> {
  final FootballPlayersRepository _repository;

  CountryFootballPlayersBloc(this._repository) : super(CountryFootballPlayersStateInitial()) {
    on<CountryFootballPlayersEvent>(
      (event, emitter) => switch (event) {
        CountryFootballPlayersEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    CountryFootballPlayersEventGet event,
    Emitter<CountryFootballPlayersState> emit,
  ) async {
    try {
      emit(CountryFootballPlayersStatePending());
      final players = await _repository.cardsGet(event.countryId);
      final countries = await _repository.countriesGet([event.countryId]);
      emit(CountryFootballPlayersStateLoadSucceeded(players, countries.first));
    } on Object catch (_) {
      emit(CountryFootballPlayersStateFailed('Произошла ошибка'));
    }
  }
}
