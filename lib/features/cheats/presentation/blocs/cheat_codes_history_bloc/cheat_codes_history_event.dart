part of 'cheat_codes_history_bloc.dart';

sealed class CheatCodesHistoryEvent {}

class CheatCodesHistoryEventAdd extends CheatCodesHistoryEvent {
  final String code;

  CheatCodesHistoryEventAdd({required this.code});
}
