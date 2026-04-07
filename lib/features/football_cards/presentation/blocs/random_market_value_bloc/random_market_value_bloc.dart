import 'package:bloc/bloc.dart';
import 'package:football_collection/features/football_cards/data/market_values_repository.dart';

import '../../../domain/models/market_value_model.dart';

part 'random_market_value_event.dart';
part 'random_market_value_state.dart';

class RandomMarketValueBloc extends Bloc<RandomMarketValueEvent, RandomMarketValueState> {
  final MarketValuesRepository _repository;

  RandomMarketValueBloc(this._repository) : super(RandomMarketValueStateInitial()) {
    on<RandomMarketValueEvent>(
      (event, emitter) => switch (event) {
        RandomMarketValueEventGet() => _get(event, emitter),
      },
    );
  }

  Future<void> _get(RandomMarketValueEventGet event, Emitter<RandomMarketValueState> emit) async {
    try {
      emit(RandomMarketValueStatePending());
      while (true) {
        final value = await _repository.randomMarketValueHistoryGet(
          minItems: event.minItems,
          minPrimeValue: event.minPrimeTransferValue,
        );
        if (value != null) {
          emit(RandomMarketValueStateLoadSucceeded(value));
          break;
        }
      }
    } on Object catch (e) {
      emit(RandomMarketValueStateFailed(e.toString()));
    }
  }
}
