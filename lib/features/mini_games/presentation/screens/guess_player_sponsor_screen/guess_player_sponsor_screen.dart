import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../football_cards/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import '../../../../football_cards/presentation/widgets/player_card/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_player_sponsor_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessPlayerSponsorScreen extends StatelessWidget {
  const GuessPlayerSponsorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: GuessPlayerSponsorScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessPlayerSponsorScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<
                    RandomFootballPlayersBloc,
                    RandomFootballPlayersState
                  >(
                    builder: (context, randomPlayersState) {
                      final allPlayers = randomPlayersState.players ?? [];
                      final player = allPlayers.firstOrNull;

                      if (player?.outfitter == null)
                        return Align(child: const CircularProgressIndicator());

                      final sponsors = [
                        "puma",
                        "nike",
                        "adidas",
                        "new balance",
                        "under armour",
                        "skechers",
                        "mizuno",
                        "elite sport",
                        "keepersport",
                        "uhlsport",
                        "reusch",
                        "sells",
                        "onekeeper",
                        "ab1",
                        "hummel",
                        "diadora",
                      ];
                      final correctAnswer = player!.outfitter!.toLowerCase();
                      final random = Random(player.playerId.hashCode);
                      final wrongOptions = <String>[];
                      while (wrongOptions.length < 3) {
                        final wrongOption =
                            sponsors[random.nextInt(sponsors.length)];
                        if (!wrongOptions.contains(wrongOption) &&
                            wrongOption != correctAnswer) {
                          wrongOptions.add(wrongOption);
                        }
                      }
                      final options = [correctAnswer, ...wrongOptions];
                      options.shuffle(
                        Random(player.playerId.hashCode ^ 0x9E3779B9),
                      );

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Align(
                            child: FootballPlayerCardWidget(
                              player: player,
                              badge: .none,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _GuessOptions(
                            options: options,
                            rightAnswer: correctAnswer,
                          ),
                          const SizedBox(height: 20),
                          StreamBuilder<bool>(
                            stream: presenter.isBannerAlreadyCreatedStream$,
                            builder: (context, isBannerAlreadyCreatedSnapshot) {
                              if (isBannerAlreadyCreatedSnapshot.data != true)
                                return const SizedBox(height: 100);
                              return SizedBox(
                                height: 100,
                                child: AdWidget(bannerAd: presenter.banner),
                              );
                            },
                          ),
                          SizedBox(height: mq.padding.bottom),
                        ],
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.guessPlayerSponsor,
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
