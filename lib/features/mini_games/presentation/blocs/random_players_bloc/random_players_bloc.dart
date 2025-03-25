import 'package:bloc/bloc.dart';
import 'package:football_collection/features/albums/domain/models/player.dart';
import 'package:injectable/injectable.dart';

import '../../../../albums/data/players_repository.dart';

part 'random_players_bloc_event.dart';
part 'random_players_bloc_state.dart';

@singleton
class RandomPlayersBloc extends Bloc<RandomPlayersEvent, RandomPlayersState> {
  final PlayersRepository _repository;

  RandomPlayersBloc(this._repository) : super(RandomPlayersStateInitial()) {
    on<RandomPlayersEvent>(
      (event, emitter) => switch (event) {
        RandomPlayersEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    RandomPlayersEventGet event,
    Emitter<RandomPlayersState> emit,
  ) async {
    try {
      emit(RandomPlayersStatePending());
      final players = await _repository.getRandomPlayers(count: 1, hasCurrentTransferValue: event.hasTransferValue);
      emit(RandomPlayersStateLoadSucceeded(players));
    } on Object catch (_) {
      emit(RandomPlayersStateFailed('Произошла ошибка'));
    }
  }
}
