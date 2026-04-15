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

  bool get enablePackManualRotate {
    return switch (this) {
      SettingsStateReady() => (this as SettingsStateReady).enablePackManualRotateSettings,
    };
  }

  bool get enablePackAutoRotate {
    return switch (this) {
      SettingsStateReady() => (this as SettingsStateReady).enablePackAutoRotateSettings,
    };
  }

  int get packAutoRotatePerSecond {
    return switch (this) {
      SettingsStateReady() => (this as SettingsStateReady).packAutoRotatePerSecondSettings,
    };
  }

  int get packManualRotateSensitivity {
    return switch (this) {
      SettingsStateReady() => (this as SettingsStateReady).packManualRotateSensitivitySettings,
    };
  }
}

final class SettingsStateReady extends SettingsState {
  final bool enableVibrationSettings;
  final bool enableConfettiSettings;
  final bool enablePackManualRotateSettings;
  final bool enablePackAutoRotateSettings;
  final int packAutoRotatePerSecondSettings;
  final int packManualRotateSensitivitySettings;

  SettingsStateReady({
    required this.enableVibrationSettings,
    required this.enableConfettiSettings,
    required this.enablePackManualRotateSettings,
    required this.enablePackAutoRotateSettings,
    required this.packAutoRotatePerSecondSettings,
    required this.packManualRotateSensitivitySettings,
  });
}
