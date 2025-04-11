import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import 'widgets/select_language.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'settings_screen_presenter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SettingsScreenPresenter(
      child: Builder(builder: (context) {
        final presenter = SettingsScreenPresenter.of(context);
        return Scaffold(
          // backgroundColor: AppColors.darkBackgroundSecondary,
          body: Stack(
            children: [
              Column(
                children: [
                  Translator(
                    termin: AppGlossary.settings,
                    builder: (value) => TransparentAppbar(
                      title: value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LanguageSettingsTile(),
                ],
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
