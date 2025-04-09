import 'package:bloc/bloc.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:injectable/injectable.dart';

import '../../../../countries/domain/models/country.dart';
import '../../../data/football_players_repository.dart';

part 'football_players_packs_bloc_event.dart';
part 'football_players_packs_bloc_state.dart';

@singleton
class FootballPlayersPacksBloc extends Bloc<FootballPlayersPacksEvent, FootballPlayersPacksState> {
  final FootballPlayersRepository _repository;

  FootballPlayersPacksBloc(this._repository) : super(FootballPlayersPacksStateInitial()) {
    on<FootballPlayersPacksEvent>(
      (event, emitter) => switch (event) {
        FootballPlayersPacksEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    FootballPlayersPacksEventGet event,
    Emitter<FootballPlayersPacksState> emit,
  ) async {
    try {
      emit(FootballPlayersPacksStatePending());
      final packs = await _repository.packsGet(
        country: event.country,
        confederation: event.confederation,
      );
      emit(FootballPlayersPacksStateLoadSucceeded(packs));
    } on Object catch (_) {
      emit(FootballPlayersPacksStateFailed('Произошла ошибка'));
    }
  }
}
