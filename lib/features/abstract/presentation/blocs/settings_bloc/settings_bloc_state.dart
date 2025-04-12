part of 'settings_bloc.dart';

sealed class SettingsState {
  bool get enableVibrationOnPackOpening {
    return switch (this) {
      SettingsStateReady() => (this as SettingsStateReady).enableVibrationOnPackOpeningSetting,
    };
  }
}

final class SettingsStateReady extends SettingsState {
  final bool enableVibrationOnPackOpeningSetting;
  SettingsStateReady({
    required this.enableVibrationOnPackOpeningSetting,
  });
}
