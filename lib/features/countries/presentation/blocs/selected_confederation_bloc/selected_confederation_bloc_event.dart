part of 'selected_confederation_bloc.dart';

sealed class SelectedConfederationEvent {}

final class SelectedConfederationEventSelect extends SelectedConfederationEvent {
  final FootballConfederations confederation;

  SelectedConfederationEventSelect({
    required this.confederation,
  });
}

final class SelectedConfederationEventReset extends SelectedConfederationEvent {
  SelectedConfederationEventReset();
}
