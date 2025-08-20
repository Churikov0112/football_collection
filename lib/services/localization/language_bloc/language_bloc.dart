import 'package:collection/collection.dart';
import 'package:football_collection/services/firebase/firebase_methods.dart';
import 'package:football_collection/services/localization/dictionary.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'language_event.dart';
part 'language_state.dart';

@singleton
class LanguageBloc extends HydratedBloc<LanguageBlocEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(language: Languages.english)) {
    on<LanguageBlocEvent>(
      (event, emit) => switch (event) {
        LanguageBlocEventSet() => _set(event, emit),
      },
    );
  }

  Future<void> _set(LanguageBlocEventSet event, Emitter<LanguageState> emit) async {
    final previousLanguage = state.language;
    emit(LanguageState(language: event.language));

    try {
      await FirebaseStaticMethods.subscribeToTopic(event.language.englishName);
      await FirebaseStaticMethods.unsubscribeFromTopic(previousLanguage.englishName);
    } catch (e) {
      LogService.error(e.toString(), e);
    }
  }

  @override
  LanguageState fromJson(Map<String, dynamic>? json) {
    if (json?['language'] != null) {
      final valueString = json!['language'];
      final value = Languages.values.firstWhereOrNull((e) => e.name == valueString) ?? Languages.english;
      return LanguageState(language: value);
    } else {
      return const LanguageState(language: Languages.english);
    }
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) => <String, dynamic>{'language': state.language.name};
}
