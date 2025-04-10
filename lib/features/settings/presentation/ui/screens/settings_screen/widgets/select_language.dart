import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/firebase/firebase_methods.dart';
import 'package:football_collection/services/localization/dictionary.dart';
import 'package:football_collection/services/localization/language_bloc/language_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: getIt.get(),
      builder: (context, languageState) {
        return GestureDetector(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              // backgroundColor: AppColors.darkBackgroundSecondary,
              enableDrag: true,
              isDismissible: true,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              builder: (context) => const _SelectLanguageBottomSheet(),
            );
          },
          child: SizedBox(
            width: mq.size.width * 0.4,
            height: mq.size.width * 0.4,
            child: _LanguageTile(language: languageState.language),
          ),
        );
      },
    );
  }
}

class _SelectLanguageBottomSheet extends StatelessWidget {
  const _SelectLanguageBottomSheet();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SizedBox(
      height: mq.size.height - mq.padding.top - 64,
      child: GridView.builder(
        physics: ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
        itemCount: Languages.values.length,
        itemBuilder: (context, index) {
          final language = Languages.values[index];
          return GestureDetector(
            onTap: () {
              final previousLanguage = getIt.get<LanguageBloc>().state.language;
              if (language == previousLanguage) {
                Navigator.of(context).pop();
                return;
              }
              FirebaseStaticMethods.unsubscribeFromTopic(previousLanguage.englishName);
              FirebaseStaticMethods.subscribeToTopic(language.englishName);
              getIt.get<LanguageBloc>().add(LanguageBlocEventSet(language: language));
              Navigator.of(context).pop();
            },
            child: _LanguageTile(
              language: language,
            ),
          );
        },
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
  });

  final Languages language;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.black45,
        color: Colors.black45,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(language.emoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 10),
          Text(
            language.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
