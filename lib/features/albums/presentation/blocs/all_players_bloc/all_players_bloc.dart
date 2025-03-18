import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/players_repository.dart';
import '../../../domain/models/player.dart';

part 'all_players_event.dart';
part 'all_players_state.dart';

@singleton
class AllPlayersBloc extends Bloc<AllPlayersEvent, AllPlayersState> {
  final PlayersRepository repository;

  AllPlayersBloc({
    required this.repository,
  }) : super(AllPlayersStateInitial()) {
    on<AllPlayersEvent>((event, emit) async {
      if (event is AllPlayersEventLoad) {
        await _load(event, emit);
      }
    });
  }

  Future<void> _load(AllPlayersEventLoad event, Emitter emit) async {
    try {
      emit(AllPlayersStatePending());
      final players = await repository.playersGet();
      emit(AllPlayersStateLoadSucceeded(players: players));
    } catch (e) {
      emit(AllPlayersStateFailed(message: e.toString()));
    }
  }
}
