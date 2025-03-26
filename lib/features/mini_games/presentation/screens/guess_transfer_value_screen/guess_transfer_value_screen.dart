import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/random_players_bloc/random_players_bloc.dart';
import 'package:football_collection/ui_kit/utils/transfer_value_beautifier.dart';

import 'widgets/guess_options.dart';

part 'guess_transfer_value_screen_presenter.dart';

class GuessTransferValueScreen extends StatelessWidget {
  const GuessTransferValueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomPlayersBloc(getIt.get()),
      child: GuessTransferValueScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessTransferValueScreenPresenter.of(context);

            return Scaffold(
              body: BlocBuilder<RandomPlayersBloc, RandomPlayersState>(
                builder: (context, randomPlayersState) {
                  final player = randomPlayersState.players?.firstOrNull;
                  if (player == null) return Align(child: const CircularProgressIndicator());

                  final random = presenter.random;
                  final currentMarketValue = player.currentMarketValue ?? 0;
                  const allDeviationSteps = [-0.5, -0.25, 0.25, 0.5];
                  final selectedStep = allDeviationSteps[random.nextInt(allDeviationSteps.length)];

                  final randomMarketValues = [
                    currentMarketValue,
                    (currentMarketValue * (1 + selectedStep)).round(),
                  ]..shuffle(random);

                  return DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            child: SavedPlayerCard(
                              player: player,
                              count: 1,
                              hideTransferValue: true,
                            ),
                          ),
                        ),
                        GuessOptions(
                          options: randomMarketValues.map((e) => beautifyTransferValue(e)).toList(),
                          rightAnswer: beautifyTransferValue(currentMarketValue),
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
          },
        ),
      ),
    );
  }
}
