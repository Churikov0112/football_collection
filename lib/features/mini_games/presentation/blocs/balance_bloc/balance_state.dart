part of 'balance_bloc.dart';

sealed class BalanceState {
  int? get balance {
    return switch (this) {
      BalanceStateReady() => (this as BalanceStateReady)._balance,
      _ => null,
    };
  }
}

final class BalanceStateReady extends BalanceState {
  final int _balance;
  BalanceStateReady(this._balance);
}

final class BalanceStateFailed extends BalanceState {
  final String message;

  BalanceStateFailed({
    required this.message,
  });
}
