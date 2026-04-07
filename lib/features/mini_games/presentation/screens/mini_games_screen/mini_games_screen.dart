import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../di/di.dart';
import '../../../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import '../../../../../services/toast/toast_service.dart';
import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../draft/presentation/ui/screens/draft_description_screen/draft_description_screen.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'mini_games_screen_presenter.dart';
part 'widgets/mini_games_list.dart';

class MiniGamesScreen extends StatelessWidget {
  const MiniGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return MiniGamesScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = MiniGamesScreenPresenter.of(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                BackgroundImage(),
                Column(children: [const _MiniGamesList()]),
                Translator(
                  termin: AppGlossary.miniGames,
                  builder: (value) => TransparentAppbar(title: value),
                ),
                Positioned(
                  bottom: mq.padding.bottom,
                  right: 0,
                  left: 0,
                  child: StreamBuilder<bool>(
                    stream: presenter.isBannerAlreadyCreatedStream$,
                    builder: (context, isBannerAlreadyCreatedSnapshot) {
                      if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox(height: 100);
                      return SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [AdWidget(bannerAd: presenter.banner)],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
