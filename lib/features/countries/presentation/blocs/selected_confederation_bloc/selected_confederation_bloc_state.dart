part of 'selected_confederation_bloc.dart';

sealed class SelectedConfederationState {
  FootballConfederations? get confederation {
    return switch (this) {
      SelectedConfederationStateSelected() => (this as SelectedConfederationStateSelected)._confederation,
      _ => null,
    };
  }
}

final class SelectedConfederationStateInitial extends SelectedConfederationState {
  SelectedConfederationStateInitial();
}

final class SelectedConfederationStateSelected extends SelectedConfederationState {
  final FootballConfederations _confederation;
  SelectedConfederationStateSelected(this._confederation);
}
