part of 'settings_bloc.dart';

sealed class SettingsState {
  bool get enableVibration {
    return switch (this) {
      SettingsStateReady() => (this as SettingsStateReady).enableVibrationSettings,
    };
  }

  bool get enableConfetti {
    return switch (this) {
      SettingsStateReady() => (this as SettingsStateReady).enableConfettiSettings,
    };
  }
}

final class SettingsStateReady extends SettingsState {
  final bool enableVibrationSettings;
  final bool enableConfettiSettings;
  SettingsStateReady({
    required this.enableVibrationSettings,
    required this.enableConfettiSettings,
  });
}
