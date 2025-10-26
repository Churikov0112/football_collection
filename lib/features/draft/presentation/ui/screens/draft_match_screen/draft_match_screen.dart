import 'package:fc_26_england/di/di.dart';
import 'package:fc_26_england/features/draft/presentation/blocs/draft_tournament_bloc/draft_tournament_bloc.dart';
import 'package:fc_26_england/features/mini_games/domain/models/draft_tournament.dart';
import 'package:fc_26_england/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:fc_26_england/services/localization/translator.dart';
import 'package:fc_26_england/services/toast/toast_service.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' show Scaffold, showDialog, Colors, OutlinedButton, Dialog;
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/team.dart';
import 'game/match_game.dart';

part 'draft_match_screen_presenter.dart';

class DraftMatchScreenArguments {
  final FootballTeamGameModel userTeam;
  final FootballTeamGameModel oppponentTeam;

  const DraftMatchScreenArguments({
    required this.userTeam,
    required this.oppponentTeam,
  });
}

class DraftMatchScreen extends StatelessWidget {
  const DraftMatchScreen({
    required this.args,
    super.key,
  });

  final DraftMatchScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return DraftMatchScreenPresenter(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: GameWidget.controlled(
            gameFactory: () => MatchGame(
              teamA: args.userTeam,
              teamB: args.oppponentTeam,
              onMatchFinished: (teamAscore, teamBscore) async {
                final matchWon = teamAscore > teamBscore;
                final isFinal = getIt.get<DraftTournamentBloc>().state.stage == DraftTournamentStage.$final;

                await showDialog(
                  context: context,
                  barrierDismissible: false,

                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isFinal && matchWon
                                  ? AppGlossary.draftWon.translate()
                                  : matchWon
                                  ? AppGlossary.matchWon.translate()
                                  : AppGlossary.matchLost.translate(),
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              spacing: 8,
                              children: [
                                isFinal && matchWon
                                    ? OutlinedButton(
                                        onPressed: () {
                                          getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 400));
                                          ToastService.showToast(
                                            title: AppGlossary.rewarded.translate(),
                                            subtitle: "${AppGlossary.rewarded.translate()} 400 🏆",
                                            seconds: 2,
                                          );
                                          getIt.get<DraftTournamentBloc>().add(DraftTournamentEventReset());
                                          while (context.canPop()) {
                                            context.pop();
                                          }
                                        },
                                        child: const Text(
                                          "+ 400 🏆",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : matchWon
                                    ? OutlinedButton(
                                        onPressed: () {
                                          // context.pop((teamAscore, teamBscore)); // dialog
                                          context.pop((teamAscore, teamBscore)); // match screen
                                        },
                                        child: Text(
                                          AppGlossary.nextMatch.translate(),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : OutlinedButton(
                                        onPressed: () {
                                          getIt.get<DraftTournamentBloc>().add(DraftTournamentEventReset());
                                          while (context.canPop()) {
                                            context.pop();
                                          }
                                        },
                                        child: Text(
                                          AppGlossary.exitDraft.translate(),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                context.pop<(int, int)>((teamAscore, teamBscore));
              },
            ),
          ),
        ),
      ),
    );
  }
}
