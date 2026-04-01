import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../football_cards/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import '../../../../football_cards/presentation/widgets/player_card/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_who_is_more_expensive_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessWhichFootballPlayerIsMoreExpensiveScreen extends StatelessWidget {
  const GuessWhichFootballPlayerIsMoreExpensiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: GuessWhichFootballPlayerIsMoreExpensiveScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessWhichFootballPlayerIsMoreExpensiveScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
                    builder: (context, randomPlayersState) {
                      final players = randomPlayersState.players ?? [];

                      if (players.isEmpty) {
                        return Align(child: const CircularProgressIndicator());
                      }

                      final player1 = randomPlayersState.players?.firstOrNull;
                      final player2 = randomPlayersState.players?[1];

                      return StreamBuilder<String?>(
                        stream: presenter.selectedOptionStream$,
                        builder: (context, selectedOptionSnapshot) {
                          final selectedOption = selectedOptionSnapshot.data;
                          return DecoratedBox(
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: mq.padding.top + 16),
                                const Spacer(),
                                const Spacer(),
                                Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: FootballPlayerCardWidget(
                                        player: player1!,
                                        badge: .none,
                                        marketValueVisibility: selectedOption != null ? .show : .quest,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: FootballPlayerCardWidget(
                                        player: player2!,
                                        badge: .none,
                                        marketValueVisibility: selectedOption != null ? .show : .quest,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                                SizedBox(height: 16),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Translator(
                                      termin: AppGlossary.guessWhichPlayerIsMoreExpensive,
                                      builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Translator(
                                  termin: AppGlossary.left,
                                  builder: (left) => Translator(
                                    termin: AppGlossary.right,
                                    builder: (right) => Translator(
                                      termin: AppGlossary.equal,
                                      builder: (equal) => _GuessOptionsLessMoreEqual(
                                        options: ["< $left", equal, "$right >"],
                                        rightAnswer: player2.marketValue! < player1.marketValue!
                                            ? "< $left"
                                            : player2.marketValue! > player1.marketValue!
                                            ? "$right >"
                                            : equal,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
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
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.whoCostsMore,
                    builder: (value) => TransparentAppbar(title: value),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
