import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/football_players_repository.dart';
import '../../../domain/models/player.dart';

part 'all_football_players_event.dart';
part 'all_football_players_state.dart';

@singleton
class AllFootballPlayersBloc extends Bloc<AllFootballPlayersEvent, AllFootballPlayersState> {
  final FootballPlayersRepository repository;

  AllFootballPlayersBloc({
    required this.repository,
  }) : super(AllFootballPlayersStateInitial()) {
    on<AllFootballPlayersEvent>((event, emit) async {
      if (event is AllFootballPlayersEventLoad) {
        await _load(event, emit);
      }
    });
  }

  Future<void> _load(AllFootballPlayersEventLoad event, Emitter emit) async {
    try {
      emit(AllFootballPlayersStatePending());
      final players = await repository.cardsGet();
      emit(AllFootballPlayersStateLoadSucceeded(players: players));
    } catch (e) {
      emit(AllFootballPlayersStateFailed(message: e.toString()));
    }
  }
}
