import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di.dart';
import 'translator.dart';

export 'dictionary.dart';
export 'language_bloc/language_bloc.dart';

class Translator extends StatelessWidget {
  final AppGlossary termin;
  final Widget Function(String value) builder;

  const Translator({required this.termin, required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: getIt.get(),
      builder: (context, state) {
        final word = dictionary[termin]![state.language]!;

        return builder(word);
      },
    );
  }
}

extension AppGlossaryExtension on AppGlossary {
  String translate() => dictionary[this]![getIt.get<LanguageBloc>().state.language]!;
}
