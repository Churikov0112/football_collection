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

part 'guess_flag_by_country_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessFlagByCountryScreen extends StatelessWidget {
  const GuessFlagByCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GuessFlagByCountryScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = GuessFlagByCountryScreenPresenter.of(context);

          return Scaffold(
            body: Stack(
              children: [
                BackgroundImage(),
                StreamBuilder<_GuessFlagByCountryRound?>(
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
                        _CountryQuestionCard(team: round.correctAnswer),
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
                  termin: AppGlossary.guessCountryFlag,
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

class _CountryQuestionCard extends StatelessWidget {
  const _CountryQuestionCard({required this.team});

  final FootballNationalTeamModel team;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(.circular(8)),
        color: Color(0xFF1F5ED3),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))],
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(.circular(8)),
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF).withValues(alpha: 0.3),
              const Color.fromARGB(0, 255, 255, 255),
              Color(0xFFFFFFFF).withValues(alpha: 0.3),
              // Colors.transparent,
              const Color.fromARGB(0, 255, 255, 255),
              Color(0xFFFFFFFF).withValues(alpha: 0.3),
              Color.fromARGB(84, 8, 12, 86).withValues(alpha: 0.2),
              Color(0xFFFFFFFF).withValues(alpha: 0.3),
            ],
            stops: [0.05, 0.18, 0.3, 0.50, 0.7, 0.85, 1],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SizedBox(
          width: mq.size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              team.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
