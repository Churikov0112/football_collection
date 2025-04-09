import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/utils/transfer_value_beautifier.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../football_players/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import '../../../../football_players/presentation/widgets/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/guess_options.dart';

part 'guess_transfer_value_screen_presenter.dart';

class GuessTransferValueScreen extends StatelessWidget {
  const GuessTransferValueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: GuessTransferValueScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessTransferValueScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
                    builder: (context, randomPlayersState) {
                      final player = randomPlayersState.players?.firstOrNull;
                      if (player == null) return Align(child: const CircularProgressIndicator());

                      final random = presenter.random;
                      final currentMarketValue = player.currentMarketValue ?? 0;
                      const allDeviationSteps = [-0.75, -0.5, -0.25, 0.25, 0.5, 0.75, 1];
                      final selectedStep = allDeviationSteps[random.nextInt(allDeviationSteps.length)];

                      final randomMarketValues = [
                        currentMarketValue,
                        (currentMarketValue * (1 + selectedStep)).round(),
                      ]..shuffle(random);

                      return DecoratedBox(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder<String?>(
                                stream: presenter.selectedOptionStream$,
                                builder: (context, selectedOptionSnapshot) {
                                  return Align(
                                    child: FootballPlayerCard(
                                      player: player,
                                      count: 1,
                                      hideTransferValue: selectedOptionSnapshot.data == null,
                                    ),
                                  );
                                }),
                            const SizedBox(height: 20),
                            GuessOptions(
                              options: randomMarketValues.map((e) => beautifyTransferValue(e)).toList(),
                              rightAnswer: beautifyTransferValue(currentMarketValue),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.guessTransferValue,
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
