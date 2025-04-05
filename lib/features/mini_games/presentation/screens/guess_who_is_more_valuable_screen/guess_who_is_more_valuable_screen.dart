import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/random_players_bloc/random_players_bloc.dart';
import 'package:football_collection/features/players/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/guess_options.dart';

part 'guess_who_is_more_valuable_screen_presenter.dart';

class GuessWhoIsMoreValuableScreen extends StatelessWidget {
  const GuessWhoIsMoreValuableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomPlayersBloc(getIt.get()),
      child: GuessWhoIsMoreValuableScreenPresenter(
        child: Builder(builder: (context) {
          final presenter = GuessWhoIsMoreValuableScreenPresenter.of(context);

          return Scaffold(
            body: Stack(
              children: [
                BackgroundImage(),
                BlocBuilder<RandomPlayersBloc, RandomPlayersState>(
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
                              Row(
                                children: [
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: SavedPlayerCard(
                                      player: player1!,
                                      count: 1,
                                      hideTransferValue: selectedOption == null,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: SavedPlayerCard(
                                      player: player2!,
                                      count: 1,
                                      hideTransferValue: selectedOption == null,
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
                                  child: Text(
                                    "Guess which player is more pricy!",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              GuessOptionsLessMoreEqual(
                                options: ["< left", "equal", "right >"],
                                rightAnswer: player2.currentMarketValue! < player1.currentMarketValue!
                                    ? "< left"
                                    : player2.currentMarketValue! > player1.currentMarketValue!
                                        ? "right >"
                                        : "equal",
                              ),
                              SizedBox(height: mq.padding.bottom + 20),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                TransparentAppbar(title: "Who costs more?"),
              ],
            ),
          );
        }),
      ),
    );
  }
}
