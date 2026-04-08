import 'package:bloc/bloc.dart';
import 'package:football_collection/features/football_cards/domain/models/club_model.dart';

import '../../../data/football_clubs_repository.dart';

part 'random_football_clubs_event.dart';
part 'random_football_clubs_state.dart';

class RandomFootballClubsBloc extends Bloc<RandomFootballClubsEvent, RandomFootballClubsState> {
  final FootballClubsRepository _repository;

  RandomFootballClubsBloc(this._repository) : super(RandomFootballClubsStateInitial()) {
    on<RandomFootballClubsEvent>(
      (event, emitter) => switch (event) {
        RandomFootballClubsEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(RandomFootballClubsEventGet event, Emitter<RandomFootballClubsState> emit) async {
    try {
      emit(RandomFootballClubsStatePending());
      final clubs = await _repository.randomClubsGet(
        count: event.count,
        withStadiumName: event.withStadiumName,
        withStadiumSeats: event.withStadiumSeats,
      );
      emit(RandomFootballClubsStateLoadSucceeded(clubs));
    } on Object catch (e) {
      emit(RandomFootballClubsStateFailed(e.toString()));
    }
  }
}
