part of 'saved_cards_bloc.dart';

sealed class SavedCardsEvent {}

class SavedCardsEventAdd extends SavedCardsEvent {
  final String cardId;

  SavedCardsEventAdd({
    required this.cardId,
  });
}

class SavedCardsEventAddAll extends SavedCardsEvent {
  final List<String> cardIds;

  SavedCardsEventAddAll({
    required this.cardIds,
  });
}

class SavedCardsEventRemove extends SavedCardsEvent {
  final String cardId;

  SavedCardsEventRemove({
    required this.cardId,
  });
}

class SavedCardsEventRemoveAll extends SavedCardsEvent {
  final List<String> cardIds;

  SavedCardsEventRemoveAll({
    required this.cardIds,
  });
}

class SavedCardsEventSetAll extends SavedCardsEvent {
  final List<String> cardIds;

  SavedCardsEventSetAll({
    required this.cardIds,
  });
}
