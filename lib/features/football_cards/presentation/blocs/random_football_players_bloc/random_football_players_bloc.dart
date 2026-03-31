import 'package:bloc/bloc.dart';

import '../../../data/football_players_repository.dart';
import '../../../domain/models/player.dart';

part 'random_football_players_bloc_event.dart';
part 'random_football_players_bloc_state.dart';

class RandomFootballPlayersBloc extends Bloc<RandomFootballPlayersEvent, RandomFootballPlayersState> {
  final CommonFootballRepository _repository;

  RandomFootballPlayersBloc(this._repository) : super(RandomFootballPlayersStateInitial()) {
    on<RandomFootballPlayersEvent>(
      (event, emitter) => switch (event) {
        RandomFootballPlayersEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(RandomFootballPlayersEventGet event, Emitter<RandomFootballPlayersState> emit) async {
    try {
      emit(RandomFootballPlayersStatePending());
      final players = await _repository.getRandomCards(
        count: event.count,
        minPrimeTransferValue: event.minPrimeTransferValue,
        unique: event.unique,
      );
      emit(RandomFootballPlayersStateLoadSucceeded(players));
    } on Object catch (_) {
      emit(RandomFootballPlayersStateFailed('Произошла ошибка'));
    }
  }
}
