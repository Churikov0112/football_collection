import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/random_players_bloc/random_players_bloc.dart';

import 'widgets/guess_options.dart';

part 'guess_transfer_value_less_more_screen_presenter.dart';

class GuessTransferValueLessMoreScreen extends StatelessWidget {
  const GuessTransferValueLessMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomPlayersBloc(getIt.get()),
      child: GuessTransferValueLessMoreScreenPresenter(
        child: Builder(builder: (context) {
          final presenter = GuessTransferValueLessMoreScreenPresenter.of(context);

          return Scaffold(
            // appBar: AppBar(),
            body: BlocBuilder<RandomPlayersBloc, RandomPlayersState>(
              builder: (context, randomPlayersState) {
                final players = randomPlayersState.players ?? [];

                if (players.isEmpty) {
                  return Align(child: const CircularProgressIndicator());
                }

                final player1 = randomPlayersState.players?.firstOrNull;
                final player2 = randomPlayersState.players?[1];

                return DecoratedBox(
                  decoration: BoxDecoration(),
                  child: Column(
                    children: [
                      SizedBox(height: mq.padding.top + 16),
                      Align(
                        child: SavedPlayerCard(
                          player: player1!,
                          count: 1,
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        child: SavedPlayerCard(
                          player: player2!,
                          count: 1,
                          hideTransferValue: true,
                        ),
                      ),
                      SizedBox(height: 16),
                      GuessOptionsLessMoreEqual(
                        options: ["less", "equal", "more"],
                        rightAnswer: player2.currentMarketValue! < player1.currentMarketValue!
                            ? "less"
                            : player2.currentMarketValue! > player1.currentMarketValue!
                                ? "more"
                                : "equal",
                      ),
                      SizedBox(height: mq.padding.bottom + 20),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child:
                      //   Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: OutlinedButton(
                      //               onPressed: () {},
                      //               child: Text("data"),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 16),
                      //           Expanded(
                      //             child: OutlinedButton(
                      //               onPressed: () {},
                      //               child: Text("data"),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 8),
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: OutlinedButton(
                      //               onPressed: () {},
                      //               child: Text("data"),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 16),
                      //           Expanded(
                      //             child: OutlinedButton(
                      //               onPressed: () {},
                      //               child: Text("data"),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
