part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class SettingsEventSet extends SettingsEvent {
  final bool enableVibrationOnPackOpening;
  SettingsEventSet({
    required this.enableVibrationOnPackOpening,
  });
}
