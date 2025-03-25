part of 'balance_bloc.dart';

sealed class BalanceEvent {}

class BalanceEventIncrease extends BalanceEvent {
  final int amount;

  BalanceEventIncrease({
    required this.amount,
  });
}

class BalanceEventDecrease extends BalanceEvent {
  final int amount;

  BalanceEventDecrease({
    required this.amount,
  });
}
