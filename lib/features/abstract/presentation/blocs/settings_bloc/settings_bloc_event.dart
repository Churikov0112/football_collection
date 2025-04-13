part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class SettingsEventSet extends SettingsEvent {
  final bool enableVibration;
  final bool enableConfetti;

  SettingsEventSet({
    required this.enableVibration,
    required this.enableConfetti,
  });
}
