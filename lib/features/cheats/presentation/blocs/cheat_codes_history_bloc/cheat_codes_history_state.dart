part of 'cheat_codes_history_bloc.dart';

sealed class CheatCodesHistoryState {
  List<String>? get history {
    return switch (this) {
      CheatCodesHistoryStateLoadSucceeded() => (this as CheatCodesHistoryStateLoadSucceeded)._history,
      _ => null,
    };
  }
}

final class CheatCodesHistoryStateInitial extends CheatCodesHistoryState {}

final class CheatCodesHistoryStatePending extends CheatCodesHistoryState {}

final class CheatCodesHistoryStateLoadSucceeded extends CheatCodesHistoryState {
  final List<String> _history;
  CheatCodesHistoryStateLoadSucceeded(this._history);
}

final class CheatCodesHistoryStateFailed extends CheatCodesHistoryState {
  final String message;

  CheatCodesHistoryStateFailed({required this.message});
}
