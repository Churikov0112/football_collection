part of 'random_market_value_bloc.dart';

sealed class RandomMarketValueState {
  MarketValueModel? get value {
    return switch (this) {
      RandomMarketValueStateLoadSucceeded() => (this as RandomMarketValueStateLoadSucceeded)._value,
      _ => null,
    };
  }
}

final class RandomMarketValueStateInitial extends RandomMarketValueState {
  RandomMarketValueStateInitial();
}

final class RandomMarketValueStatePending extends RandomMarketValueState {
  RandomMarketValueStatePending();
}

final class RandomMarketValueStateLoadSucceeded extends RandomMarketValueState {
  final MarketValueModel _value;
  RandomMarketValueStateLoadSucceeded(this._value);
}

final class RandomMarketValueStateFailed extends RandomMarketValueState {
  final String reason;
  RandomMarketValueStateFailed(this.reason);
}
