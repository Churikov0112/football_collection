import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/settings_bloc/settings_bloc.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:rxdart/subjects.dart';
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
                  const SizedBox(height: 20),
                  StreamBuilder<bool>(
                    stream: presenter.enableVibrationOnPackOpeningStream$,
                    builder: (context, enableVibrationOnPackOpeningSnapshot) {
                      return SwitchListTile(
                        title: Translator(
                          termin: AppGlossary.settingsVibrationOnPackOpening,
                          builder: (value) => Text(value),
                        ),
                        value: enableVibrationOnPackOpeningSnapshot.data ?? false,
                        onChanged: (val) {
                          presenter.toggleEnableVibrationOnPackOpening(val);
                        },
                      );
                    },
                  ),
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
