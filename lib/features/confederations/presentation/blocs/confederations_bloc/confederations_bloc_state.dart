part of 'confederations_bloc.dart';

sealed class ConfederationsState {
  List<Confederations>? get confederations {
    return switch (this) {
      ConfederationsStateLoadSucceeded() => (this as ConfederationsStateLoadSucceeded)._confederations,
      _ => null,
    };
  }
}

final class ConfederationsStateInitial extends ConfederationsState {
  ConfederationsStateInitial();
}

final class ConfederationsStatePending extends ConfederationsState {
  ConfederationsStatePending();
}

final class ConfederationsStateLoadSucceeded extends ConfederationsState {
  final List<Confederations> _confederations;
  ConfederationsStateLoadSucceeded(this._confederations);
}

final class ConfederationsStateFailed extends ConfederationsState {
  final String reason;
  ConfederationsStateFailed(this.reason);
}
