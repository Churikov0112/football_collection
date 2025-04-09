import 'package:flutter/material.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';

import 'widgets/select_language.dart';

part 'settings_screen_presenter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return SettingsScreenPresenter(
      child: Scaffold(
        // backgroundColor: AppColors.darkBackgroundSecondary,
        body: Column(
          children: [
            Translator(
              termin: AppGlossary.settings,
              builder: (value) => TransparentAppbar(
                title: value,
              ),
            ),
            const SizedBox(height: 20),
            LanguageTile(),
          ],
        ),
      ),
    );
  }
}
