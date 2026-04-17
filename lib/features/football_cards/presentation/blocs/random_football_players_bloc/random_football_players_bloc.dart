import 'package:bloc/bloc.dart';

import '../../../../abstract/domain/models/card.dart';
import '../../../data/football_players_repository.dart';
import '../../../domain/cards/player_card.dart';

part 'random_football_players_bloc_event.dart';
part 'random_football_players_bloc_state.dart';

class RandomFootballPlayersBloc
    extends Bloc<RandomFootballPlayersEvent, RandomFootballPlayersState> {
  final CommonFootballRepository _repository;

  RandomFootballPlayersBloc(this._repository)
    : super(RandomFootballPlayersStateInitial()) {
    on<RandomFootballPlayersEvent>(
      (event, emitter) => switch (event) {
        RandomFootballPlayersEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(
    RandomFootballPlayersEventGet event,
    Emitter<RandomFootballPlayersState> emit,
  ) async {
    try {
      emit(RandomFootballPlayersStatePending());
      final players = await _repository.getRandomCards(
        cardTypes: {CardType.player},
        count: event.count,
        minPrimeTransferValue: event.minPrimeTransferValue,
        withSponsor: event.withSponsor,
        withSecondCitizenship: event.withSecondCitizenship,
        withHeight: event.withHeight,
        withPosition: event.withPosition,
        withFoot: event.withFoot,
        withTeamShirtNumber: event.withTeamShirtNumber,
        withClubName: event.withClubName,
        withAge: event.withAge,
        withJoinedClubOn: event.withJoinedClubOn,
        unique: event.unique,
      );
      emit(
        RandomFootballPlayersStateLoadSucceeded(
          players.whereType<FootballPlayerCardModel>().toList(),
        ),
      );
    } on Object catch (_) {
      emit(RandomFootballPlayersStateFailed('Произошла ошибка'));
    }
  }
}
