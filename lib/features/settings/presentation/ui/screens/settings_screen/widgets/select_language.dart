import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/dictionary.dart';
import 'package:football_collection/services/localization/language_bloc/language_bloc.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: getIt.get(),
      builder: (context, languageState) {
        return ListTile(
          title: Text("${languageState.language.name} ${languageState.language.emoji}"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const _SelectLanguageBottomSheet(),
            );
          },
        );
      },
    );
  }
}

class _SelectLanguageBottomSheet extends StatelessWidget {
  const _SelectLanguageBottomSheet();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Languages.values.length,
      itemBuilder: (context, index) {
        final language = Languages.values[index];
        return ListTile(
          title: Text("${language.name} ${language.emoji}"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            getIt.get<LanguageBloc>().add(LanguageBlocEventSet(language: language));
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
