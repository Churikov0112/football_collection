part of 'all_football_cards_bloc.dart';

sealed class AllFootballCardsEvent {}

class AllFootballCardsEventLoad extends AllFootballCardsEvent {
  final bool fromRuntimeCache;

  AllFootballCardsEventLoad({this.fromRuntimeCache = false});
}
