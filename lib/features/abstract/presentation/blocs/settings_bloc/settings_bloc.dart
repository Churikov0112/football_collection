import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'settings_bloc_event.dart';
part 'settings_bloc_state.dart';

final _default = SettingsStateReady(
  enableVibrationSettings: true,
  enableConfettiSettings: true,
);

@singleton
class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(_default) {
    on<SettingsEvent>(
      (event, emitter) => switch (event) {
        SettingsEventSet() => _set(event, emitter),
      },
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
      ),
    );
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    try {
      return SettingsStateReady(
        enableVibrationSettings: json["enableVibrationSettings"],
        enableConfettiSettings: json["enableConfettiSettings"],
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
    };
    return json;
  }
}
