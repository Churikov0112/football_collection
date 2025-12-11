import 'package:flame/game.dart';
import 'package:flutter/material.dart' show Colors, Dialog, FilledButton, OutlinedButton, showDialog;
import 'package:flutter/widgets.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../di/di.dart';
import '../../../../../../services/toast/toast_service.dart';
import '../../../../../mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import '../../../../domain/models/draft_tournament.dart';
import '../../../../domain/models/draft_tournament_match.dart';
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
    final mq = MediaQuery.of(context);
    final isFinal = getIt.get<DraftTournamentBloc>().state.stage == DraftTournamentStage.$final;

    return DraftMatchScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = DraftMatchScreenPresenter.of(context);

          return PopScope(
            canPop: false,
            child: Stack(
              children: [
                GameWidget.controlled(
                  gameFactory: () => MatchGame(
                    teamA: widget.args.userTeam,
                    teamB: widget.args.oppponentTeam,
                    onScored: (teamAscore, teamBscore, scoredPlayer, elapsedTime) async {
                      presenter.setScore(teamAscore, teamBscore);

                      if (scoredPlayer?.teamId == widget.args.userTeam.id) {
                        Confetti.launch(
                          context,
                          options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6),
                        );
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
                      presenter.setScore(teamAscore, teamBscore);
                      presenter.setMatchFinished();
                      final matchWon = teamAscore > teamBscore;
                      presenter.setMatchWon(matchWon);
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
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        child: Text(
                                          AppGlossary.next.translate(),
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
                    },
                  ),
                ),

                Positioned(
                  bottom: mq.padding.bottom + 16,
                  left: 16,
                  right: 16,
                  child: StreamBuilder(
                    stream: presenter.score$,
                    builder: (context, scoreSnapshot) {
                      return StreamBuilder(
                        stream: presenter.matchWon$,
                        builder: (context, matchWonSnapshot) {
                          return StreamBuilder(
                            stream: presenter.matchFinished$,
                            builder: (context, matchFinishedSnapshot) {
                              final matchWon = matchWonSnapshot.data;
                              final score = scoreSnapshot.data;
                              final matchFinished = matchFinishedSnapshot.data;

                              if (matchWon == null || score == null || matchFinished == null) {
                                return const SizedBox.shrink();
                              }

                              return FilledButton(
                                onPressed: () {
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
                                    getIt.get<DraftTournamentBloc>().add(
                                      DraftTournamentEventNextMatch(
                                        playedMatch: DraftTournamentMatchModel(
                                          teamA: widget.args.userTeam,
                                          teamB: widget.args.oppponentTeam,
                                          teamAScore: score.$1,
                                          teamBScore: score.$2,
                                        ),
                                      ),
                                    );
                                    context.pop(); // match screen
                                  } else {
                                    getIt.get<DraftTournamentBloc>().add(DraftTournamentEventReset());
                                    while (context.canPop()) {
                                      context.pop();
                                    }
                                  }
                                },
                                child: isFinal && matchWon
                                    ? const Text("+ 400 🏆", style: TextStyle(color: Colors.white))
                                    : matchWon
                                    ? Text(
                                        AppGlossary.nextMatch.translate(),
                                        style: const TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        AppGlossary.exitDraft.translate(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
