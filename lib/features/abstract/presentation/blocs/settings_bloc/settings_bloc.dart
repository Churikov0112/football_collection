import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'settings_bloc_event.dart';
part 'settings_bloc_state.dart';

final _default = SettingsStateReady(
  enableVibrationSettings: true,
  enableConfettiSettings: true,
  enablePackManualRotateSettings: true,
  enablePackAutoRotateSettings: false,
  packAutoRotatePerSecondSettings: 270,
  packManualRotateSensitivitySettings: 2,
);

@singleton
class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(_default) {
    on<SettingsEvent>(
      (event, emitter) => switch (event) {
        SettingsEventSet() => _set(event, emitter),
      },
      transformer: restartable(),
    );
  }

  Future<void> _set(
    SettingsEventSet event,
    Emitter<SettingsState> emit,
  ) async {
    emit(
      SettingsStateReady(
        enableVibrationSettings: event.enableVibration,
        enableConfettiSettings: event.enableConfetti,
        enablePackManualRotateSettings: event.enablePackManualRotate,
        enablePackAutoRotateSettings: event.enablePackAutoRotate,
        packAutoRotatePerSecondSettings: event.autoRotatePerSecond,
        packManualRotateSensitivitySettings: event.packManualRotateSensitivity,
      ),
    );
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    try {
      return SettingsStateReady(
        enableVibrationSettings: json["enableVibrationSettings"],
        enableConfettiSettings: json["enableConfettiSettings"],
        enablePackManualRotateSettings: json["enablePackManualRotate"],
        enablePackAutoRotateSettings: json["enablePackAutoRotate"],
        packAutoRotatePerSecondSettings: json["packAutoRotatePerSecond"],
        packManualRotateSensitivitySettings: json["packManualRotateSensitivity"],
      );
    } catch (e) {
      return _default;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    final json = {
      "enableVibrationSettings": state.enableVibration,
      "enableConfettiSettings": state.enableConfetti,
      "enablePackManualRotate": state.enablePackManualRotate,
      "enablePackAutoRotate": state.enablePackAutoRotate,
      "packAutoRotatePerSecond": state.packAutoRotatePerSecond,
      "packManualRotateSensitivity": state.packManualRotateSensitivity,
    };
    return json;
  }
}
