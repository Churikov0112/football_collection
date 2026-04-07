part of 'random_market_value_bloc.dart';

sealed class RandomMarketValueEvent {}

final class RandomMarketValueEventGet extends RandomMarketValueEvent {
  final int minItems;
  final int? minPrimeTransferValue;

  RandomMarketValueEventGet({this.minPrimeTransferValue, this.minItems = 2});
}
