import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'balance_event.dart';
part 'balance_state.dart';

const _kBalanceKey = 'balance';

@singleton
class BalanceBloc extends HydratedBloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(BalanceStateReady(500)) {
    on<BalanceEvent>(
      (event, emitter) => switch (event) {
        BalanceEventIncrease() => _increase(event, emitter),
        BalanceEventDecrease() => _decrease(event, emitter),
        BalanceEventSet() => _set(event, emitter),
      },
    );
  }

  Future<void> _set(BalanceEventSet event, Emitter emit) async {
    try {
      emit(BalanceStateReady(event.amount));
    } catch (e) {
      emit(BalanceStateFailed(message: e.toString()));
    }
  }

  Future<void> _increase(BalanceEventIncrease event, Emitter emit) async {
    try {
      final balanceCopy = state.balance ?? 0;
      emit(BalanceStateReady(balanceCopy + event.amount));
    } catch (e) {
      emit(BalanceStateFailed(message: e.toString()));
    }
  }

  Future<void> _decrease(BalanceEventDecrease event, Emitter emit) async {
    try {
      final balanceCopy = state.balance ?? 0;
      if (balanceCopy - event.amount < 0) {
        emit(BalanceStateFailed(message: "Fill your balance"));
        emit(BalanceStateReady(balanceCopy));
      } else {
        emit(BalanceStateReady(balanceCopy - event.amount));
      }
    } catch (e) {
      emit(BalanceStateFailed(message: e.toString()));
    }
  }

  @override
  BalanceState fromJson(Map<String, dynamic> json) {
    try {
      if (json[_kBalanceKey] != null) {
        final int balance = json[_kBalanceKey];
        return BalanceStateReady(balance);
      }
      return BalanceStateReady(0);
    } catch (e) {
      return BalanceStateReady(0);
    }
  }

  @override
  Map<String, dynamic>? toJson(BalanceState state) {
    final json = {
      _kBalanceKey: state.balance ?? 0,
    };
    return json;
  }
}
