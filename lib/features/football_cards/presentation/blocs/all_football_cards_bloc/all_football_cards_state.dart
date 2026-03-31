part of 'all_football_cards_bloc.dart';

sealed class AllFootballCardsState {
  List<CardModel>? get cards {
    return switch (this) {
      AllFootballCardsStateLoadSucceeded() => (this as AllFootballCardsStateLoadSucceeded)._cards,
      _ => null,
    };
  }
}

final class AllFootballCardsStateInitial extends AllFootballCardsState {}

final class AllFootballCardsStatePending extends AllFootballCardsState {}

final class AllFootballCardsStateLoadSucceeded extends AllFootballCardsState {
  final List<CardModel> _cards;

  AllFootballCardsStateLoadSucceeded(this._cards);
}

final class AllFootballCardsStateFailed extends AllFootballCardsState {
  final String message;

  AllFootballCardsStateFailed({required this.message});
}
