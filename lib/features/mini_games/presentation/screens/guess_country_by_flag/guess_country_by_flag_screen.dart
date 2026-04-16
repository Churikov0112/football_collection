import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_cards/data/football_players_repository.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../services/flag_color_similarity/flag_color_similarity_service.dart';
import '../../../../../services/flag_color_similarity/team_flag_colors.dart';
import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_country_by_flag_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessCountryByFlagScreen extends StatelessWidget {
  const GuessCountryByFlagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GuessCountryByFlagScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = GuessCountryByFlagScreenPresenter.of(context);

          return Scaffold(
            body: Stack(
              children: [
                BackgroundImage(),
                StreamBuilder<_GuessCountryByFlagRound?>(
                  stream: presenter.roundStream$,
                  builder: (context, roundSnapshot) {
                    if (presenter.isPreparingGame) {
                      return Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text(
                                'Preparing flags ${presenter.prepareProgressPercent}%',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final round = roundSnapshot.data;
                    if (round == null) {
                      return const Align(child: CircularProgressIndicator());
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(flex: 2),
                        _FlagCard(team: round.correctAnswer),
                        const Spacer(),
                        _GuessOptions(options: round.options, rightAnswer: round.correctAnswer),
                        const SizedBox(height: 20),
                        StreamBuilder<bool>(
                          stream: presenter.isBannerAlreadyCreatedStream$,
                          builder: (context, isBannerAlreadyCreatedSnapshot) {
                            if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox(height: 100);
                            return SizedBox(height: 100, child: AdWidget(bannerAd: presenter.banner));
                          },
                        ),
                        SizedBox(height: mq.padding.bottom),
                      ],
                    );
                  },
                ),
                Translator(
                  termin: AppGlossary.guessCountryByFlag,
                  builder: (value) => TransparentAppbar(title: value),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FlagCard extends StatelessWidget {
  const _FlagCard({required this.team});

  final FootballNationalTeamModel team;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // return DecoratedBox(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //     image: DecorationImage(image: AssetImage('assets/raster/team_flags/${team.id}.jpg')),
    //   ),
    //   child: SizedBox.square(dimension: mq.size.width / 2),
    // );
    return Text(emojiFlagByCountryName(team.name) ?? "", style: TextStyle(fontSize: mq.size.width / 5));
  }
}
