import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/random_players_bloc/random_players_bloc.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocs/balance_bloc/balance_bloc.dart';
import '../../widgets/balance_widget/balance_widget.dart';
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
            appBar: AppBar(
              title: Row(
                children: [
                  const Text("Guess Transfer Value"),
                  const Spacer(),
                  const BalanceWidget(),
                ],
              ),
            ),
            // appBar: AppBar(),
            body: BlocBuilder<RandomPlayersBloc, RandomPlayersState>(
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
                            Text("Guess which player is more pricy!"),
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
                    });
              },
            ),
          );
        }),
      ),
    );
  }
}
