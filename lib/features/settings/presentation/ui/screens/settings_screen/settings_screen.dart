import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/settings_bloc/settings_bloc.dart';
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
      child: Builder(
        builder: (context) {
          final presenter = SettingsScreenPresenter.of(context);

          return Scaffold(
            // backgroundColor: AppColors.darkBackgroundSecondary,
            body: BlocBuilder<SettingsBloc, SettingsState>(
              bloc: getIt.get(),
              builder: (context, settingsState) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Translator(
                          termin: AppGlossary.settings,
                          builder: (value) => TransparentAppbar(title: value, showBalance: false),
                        ),
                        const SizedBox(height: 20),
                        LanguageSettingsTile(),
                        const SizedBox(height: 20),
                        SwitchListTile(
                          title: Translator(
                            termin: AppGlossary.settingsEnableVibration,
                            builder: (value) => Text(value),
                          ),
                          value: settingsState.enableVibration,
                          onChanged: (val) {
                            presenter.toggleEnableVibration(val);
                          },
                        ),
                        SwitchListTile(
                          title: Translator(
                            termin: AppGlossary.settingsEnableConfetti,
                            builder: (value) => Text(value),
                          ),
                          value: settingsState.enableConfetti,
                          onChanged: (val) {
                            presenter.toggleEnableConfetti(val);
                          },
                        ),
                        SwitchListTile(
                          title: Translator(
                            termin: AppGlossary.settingsPackManualRotate,
                            builder: (value) => Text(value),
                          ),
                          value: settingsState.enablePackManualRotate,
                          onChanged: (val) {
                            presenter.togglePackManualRotate(val);
                          },
                        ),
                        SwitchListTile(
                          title: Translator(
                            termin: AppGlossary.settingsPackAutoRotate,
                            builder: (value) => Text(value),
                          ),
                          value: settingsState.enablePackAutoRotate,
                          onChanged: (val) {
                            presenter.togglePackAutoRotate(val);
                          },
                        ),

                        // Slider(
                        //   // title: Translator(
                        //   //   termin: AppGlossary.settingsPackAutoRotate,
                        //   //   builder: (value) => Text(value),
                        //   // ),
                        //   min: 90,
                        //   max: 360,
                        //   divisions: 9,
                        //   value: settingsState.packAutoRotatePerSecond.toDouble(),
                        //   onChanged: (val) {
                        //     presenter.changeTrackAutoRotateSpeed(val);
                        //   },
                        // ),
                        ListTile(title: Text("v. 2.2.6+26")), // CHANGE VERSION
                      ],
                    ),
                    // Positioned(
                    //   bottom: mq.padding.bottom,
                    //   right: 0,
                    //   left: 0,
                    //   child: StreamBuilder<bool>(
                    //     stream: presenter.isBannerAlreadyCreatedStream$,
                    //     builder: (context, isBannerAlreadyCreatedSnapshot) {
                    //       if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox.shrink();
                    //       return AdWidget(bannerAd: presenter.banner);
                    //     },
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
