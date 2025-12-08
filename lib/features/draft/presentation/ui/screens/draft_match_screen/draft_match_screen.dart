// ignore_for_file: use_build_context_synchronously

import 'package:flame/game.dart';
import 'package:flutter/material.dart' show Scaffold, showDialog, Colors, OutlinedButton, Dialog;
import 'package:flutter/widgets.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../di/di.dart';
import '../../../../../../services/toast/toast_service.dart';
import '../../../../../mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import '../../../../domain/models/draft_tournament.dart';
import '../../../../domain/models/team.dart';
import '../../../blocs/draft_tournament_bloc/draft_tournament_bloc.dart';
import 'game/match_game.dart';

part 'draft_match_screen_presenter.dart';

class DraftMatchScreenArguments {
  final FootballTeamGameModel userTeam;
  final FootballTeamGameModel oppponentTeam;

  const DraftMatchScreenArguments({required this.userTeam, required this.oppponentTeam});
}

class DraftMatchScreen extends StatefulWidget {
  const DraftMatchScreen({required this.args, super.key});

  final DraftMatchScreenArguments args;

  @override
  State<DraftMatchScreen> createState() => _DraftMatchScreenState();
}

class _DraftMatchScreenState extends State<DraftMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return DraftMatchScreenPresenter(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: GameWidget.controlled(
            gameFactory: () => MatchGame(
              teamA: widget.args.userTeam,
              teamB: widget.args.oppponentTeam,
              onScored: (teamAscore, teamBscore, scoredPlayer, elapsedTime) async {
                if (scoredPlayer?.teamId == widget.args.userTeam.id) {
                  Confetti.launch(context, options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6));
                }

                await showDialog(
                  context: context,
                  barrierDismissible: true,

                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("GOAL!", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                            const SizedBox(height: 8),
                            if (scoredPlayer?.data.card.name != null)
                              Text("${scoredPlayer!.data.card.name}, $elapsedTime'"),
                          ],
                        ),
                      ),
                    );
                  },
                ).timeout(Duration(seconds: 3), onTimeout: context.pop);
              },
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
                                          context.pop();
                                        },
                                        child: const Text("+ 400 🏆", style: TextStyle(color: Colors.white)),
                                      )
                                    : matchWon
                                    ? OutlinedButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        child: Text(
                                          AppGlossary.nextMatch.translate(),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : OutlinedButton(
                                        onPressed: () {
                                          context.pop();
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
                if (mounted) {
                  if (isFinal && matchWon) {
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
                  } else if (matchWon) {
                    context.pop((teamAscore, teamBscore)); // match screen
                  } else {
                    getIt.get<DraftTournamentBloc>().add(DraftTournamentEventReset());
                    while (context.canPop()) {
                      context.pop();
                    }
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
