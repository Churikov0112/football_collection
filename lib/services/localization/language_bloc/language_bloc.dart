import 'package:collection/collection.dart';
import 'package:football_collection/services/localization/dictionary.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'language_event.dart';
part 'language_state.dart';

@singleton
class LanguageBloc extends HydratedBloc<LanguageBlocEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(language: Languages.en)) {
    on<LanguageBlocEvent>(
      (event, emit) => switch (event) {
        LanguageBlocEventSet() => _set(event, emit),
      },
    );
  }

  Future<void> _set(LanguageBlocEventSet event, Emitter<LanguageState> emit) async {
    emit(LanguageState(language: event.language));
  }

  @override
  LanguageState fromJson(Map<String, dynamic>? json) {
    if (json?['language'] != null) {
      final valueString = json!['language'];
      final value = Languages.values.firstWhereOrNull((e) => e.name == valueString) ?? Languages.en;
      return LanguageState(language: value);
    } else {
      return const LanguageState(language: Languages.en);
    }
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) => <String, dynamic>{'language': state.language.name};
}
