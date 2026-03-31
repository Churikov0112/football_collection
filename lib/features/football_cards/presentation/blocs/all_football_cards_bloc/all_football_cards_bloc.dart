import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../abstract/domain/models/card.dart';
import '../../../data/football_players_repository.dart';

part 'all_football_cards_event.dart';
part 'all_football_cards_state.dart';

@singleton
class AllFootballCardsBloc extends Bloc<AllFootballCardsEvent, AllFootballCardsState> {
  final CommonFootballRepository repository;

  AllFootballCardsBloc({required this.repository}) : super(AllFootballCardsStateInitial()) {
    on<AllFootballCardsEvent>((event, emit) async {
      if (event is AllFootballCardsEventLoad) {
        await _load(event, emit);
      }
    });
  }

  Future<void> _load(AllFootballCardsEventLoad event, Emitter emit) async {
    try {
      emit(AllFootballCardsStatePending());
      final cards = await repository.getAllCards(cardTypes: CardType.values.toSet());
      emit(AllFootballCardsStateLoadSucceeded(cards));
    } catch (e) {
      emit(AllFootballCardsStateFailed(message: e.toString()));
    }
  }
}
