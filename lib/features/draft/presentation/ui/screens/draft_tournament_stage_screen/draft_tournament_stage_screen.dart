import 'package:collection/collection.dart';
import 'package:fc_26_england/di/di.dart';
import 'package:fc_26_england/features/football_players/presentation/widgets/football_player_card.dart';
import 'package:fc_26_england/features/mini_games/domain/models/draft_tournament_match.dart';
import 'package:fc_26_england/ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import 'package:fc_26_england/ui_kit/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../services/navigation/go_router/navigation.dart';
import '../../../../../mini_games/domain/models/draft_tournament.dart';
import '../../../blocs/draft_tournament_bloc/draft_tournament_bloc.dart';
import '../draft_match_screen/draft_match_screen.dart';

part 'draft_tournament_stage_screen_presenter.dart';

class DraftTournamentStageScreen extends StatelessWidget {
  const DraftTournamentStageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);
    // final theme = Theme.of(context);

    return DraftTournamentStageScreenPresenter(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
            child: BlocBuilder<DraftTournamentBloc, DraftTournamentState>(
              bloc: getIt.get(),
              builder: (context, draftTournamentState) {
                final tournament = draftTournamentState.tournament;
                final currentStage = draftTournamentState.stage;

                final tournamentTeams = tournament?.allTeams;
                final userTeam = tournamentTeams?.firstWhereOrNull((t) => t.id == "user");
                final currentRound = tournament?.allRounds.firstWhereOrNull((r) => r.stage == currentStage);
                final currentMatch = currentRound?.matches.firstWhereOrNull(
                  (m) => m.teamA?.id == userTeam?.id || m.teamB?.id == userTeam?.id,
                );
                final opponentTeam = currentMatch?.teamA?.id == userTeam?.id
                    ? currentMatch?.teamB
                    : currentMatch?.teamA;

                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/raster/field/football_field_topview.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        // TransparentAppbar(title: currentStage?.name ?? "Tournament", showBackButton: false),
                        const Spacer(),
                        if (currentStage?.name != null)
                          FrostedGlassContainer(
                            blupColor: Colors.black38,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Text(
                                currentStage!.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(width: 16),
                            if (userTeam != null)
                              Expanded(
                                child: FrostedGlassContainer(
                                  blupColor: Colors.black45,
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          userTeam.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        TeamLogoWidget.fromColors(
                                          size: 32,
                                          fillColor: userTeam.color,
                                          borderColor: Colors.white,
                                          centerColor: Colors.white,
                                        ),
                                        const SizedBox(height: 24),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            spacing: 8,
                                            children: [
                                              for (final player in userTeam.players)
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        player.data.card.sfData.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    if (userTeam.captainId == player.data.card.id) ...[
                                                      const SizedBox(width: 8),
                                                      const Text(
                                                        "C",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.amber,
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            const SizedBox(width: 16),

                            if (opponentTeam != null)
                              Expanded(
                                child: FrostedGlassContainer(
                                  blupColor: Colors.black45,
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          opponentTeam.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        TeamLogoWidget.fromTeamId(teamId: opponentTeam.id, size: 32),
                                        const SizedBox(height: 24),

                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            spacing: 8,
                                            children: [
                                              for (final player in opponentTeam.players)
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    if (opponentTeam.captainId == player.data.card.id) ...[
                                                      const Text(
                                                        "C",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.amber,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                    ],
                                                    Flexible(
                                                      child: Text(
                                                        player.data.card.sfData.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            const SizedBox(width: 16),
                          ],
                        ),
                        // const Spacer(),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GlassButton(
                            // text: "Start Match",
                            icon: Icons.sports_soccer,
                            onPressed: () async {
                              if (userTeam == null || opponentTeam == null) {
                                return;
                              }

                              final score = await context.push<(int, int)>(
                                RoutePaths.draftMatch,
                                extra: DraftMatchScreenArguments(
                                  userTeam: userTeam, // teamA
                                  oppponentTeam: opponentTeam, // teamB
                                ),
                              );

                              getIt.get<DraftTournamentBloc>().add(
                                DraftTournamentEventNextMatch(
                                  playedMatch: DraftTournamentMatchModel(
                                    teamA: userTeam,
                                    teamB: opponentTeam,
                                    teamAScore: score?.$1,
                                    teamBScore: score?.$2,
                                  ),
                                ),
                              );

                              print("userTeam: ${score?.$1.toString()}, opponentTeam: ${score?.$2.toString()}");
                            },
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
