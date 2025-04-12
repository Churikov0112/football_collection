import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'settings_bloc_event.dart';
part 'settings_bloc_state.dart';

final _default = SettingsStateReady(
  enableVibrationOnPackOpeningSetting: true,
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
        enableVibrationOnPackOpeningSetting: event.enableVibrationOnPackOpening,
      ),
    );
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    try {
      return SettingsStateReady(
        enableVibrationOnPackOpeningSetting: json["enableVibrationOnPackOpening"],
      );
    } catch (e) {
      return _default;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    final json = {
      "enableVibrationOnPackOpening": state.enableVibrationOnPackOpening,
    };
    return json;
  }
}
