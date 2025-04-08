import 'package:flutter/material.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';

part 'mini_games_screen_presenter.dart';
part 'widgets/mini_games_list.dart';

class MiniGamesScreen extends StatelessWidget {
  const MiniGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return MiniGamesScreenPresenter(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            BackgroundImage(),
            Column(
              children: [
                const _MiniGamesList(),
              ],
            ),
            Translator(
              termin: AppGlossary.miniGames,
              builder: (value) => TransparentAppbar(title: value),
            ),
          ],
        ),
      ),
    );
  }
}
