import 'package:bloc/bloc.dart';
import 'package:football_collection/features/albums/data/players_repository.dart';
import 'package:football_collection/features/albums/domain/models/player.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

part 'country_players_bloc_event.dart';
part 'country_players_bloc_state.dart';

@singleton
class CountryPlayersBloc extends Bloc<CountryPlayersEvent, CountryPlayersState> {
  final PlayersRepository _repository;

  CountryPlayersBloc(this._repository) : super(CountryPlayersStateInitial()) {
    on<CountryPlayersEvent>(
      (event, emitter) => switch (event) {
        CountryPlayersEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    CountryPlayersEventGet event,
    Emitter<CountryPlayersState> emit,
  ) async {
    try {
      emit(CountryPlayersStatePending());
      final players = await _repository.playersGet(event.countryId);
      final countries = await _repository.countriesGet([event.countryId]);
      emit(CountryPlayersStateLoadSucceeded(players, countries.first));
    } on Object catch (_) {
      emit(CountryPlayersStateFailed('Произошла ошибка'));
    }
  }
}
