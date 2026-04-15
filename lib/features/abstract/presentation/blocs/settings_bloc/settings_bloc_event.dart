part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class SettingsEventSet extends SettingsEvent {
  final bool enableVibration;
  final bool enableConfetti;
  final bool enablePackManualRotate;
  final bool enablePackAutoRotate;
  final int autoRotatePerSecond;
  final int packAutoRotatePerSecond;
  final int packManualRotateSensitivity;

  SettingsEventSet({
    required this.enableVibration,
    required this.enableConfetti,
    required this.enablePackManualRotate,
    required this.enablePackAutoRotate,
    required this.autoRotatePerSecond,
    required this.packAutoRotatePerSecond,
    required this.packManualRotateSensitivity,
  });
}
