import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'mini_games_screen_presenter.dart';
part 'widgets/mini_games_list.dart';

class MiniGamesScreen extends StatelessWidget {
  const MiniGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return MiniGamesScreenPresenter(
      child: Builder(builder: (context) {
        final presenter = MiniGamesScreenPresenter.of(context);
        return Scaffold(
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
              Positioned(
                bottom: mq.padding.bottom,
                right: 0,
                left: 0,
                child: StreamBuilder<bool>(
                  stream: presenter.isBannerAlreadyCreatedStream$,
                  builder: (context, isBannerAlreadyCreatedSnapshot) {
                    if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox.shrink();
                    return AdWidget(bannerAd: presenter.banner);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
