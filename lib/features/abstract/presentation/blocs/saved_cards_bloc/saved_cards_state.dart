part of 'saved_cards_bloc.dart';

sealed class SavedCardsState {
  List<String>? get savedCardsIds {
    return switch (this) {
      SavedCardsStateLoadSucceeded() => (this as SavedCardsStateLoadSucceeded)._savedCardsIds,
      _ => null,
    };
  }
}

final class SavedCardsStateInitial extends SavedCardsState {}

final class SavedCardsStatePending extends SavedCardsState {}

final class SavedCardsStateLoadSucceeded extends SavedCardsState {
  final List<String> _savedCardsIds;
  SavedCardsStateLoadSucceeded(this._savedCardsIds);
}

final class SavedCardsStateFailed extends SavedCardsState {
  final String message;

  SavedCardsStateFailed({
    required this.message,
  });
}
