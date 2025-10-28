import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/draft/domain/models/position.dart';
import 'package:football_collection/features/football_players/data/football_players_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../services/log/log_service.dart';
import '../../../../football_players/domain/models/player.dart';
import '../../../domain/models/draft_tournament.dart';
import '../../../domain/models/draft_tournament_match.dart';
import '../../../domain/models/draft_tournament_round.dart';
import '../../../domain/models/player.dart';
import '../../../domain/models/position_weights.dart';
import '../../../domain/models/ratings.dart';
import '../../../domain/models/schemes.dart';
import '../../../domain/models/stats.dart';
import '../../../domain/models/team.dart';

part 'draft_tournament_bloc_event.dart';
part 'draft_tournament_bloc_state.dart';

@singleton
class DraftTournamentBloc extends Bloc<DraftTournamentEvent, DraftTournamentState> {
  final FootballPlayersRepository _repository;
  final Random random = Random();

  DraftTournamentBloc(this._repository) : super(DraftTournamentStateInitial()) {
    on<DraftTournamentEvent>(
      (event, emitter) => switch (event) {
        DraftTournamentEventStart() => _start(event, emitter),
        DraftTournamentEventNextMatch() => _nextMatch(event, emitter),
        DraftTournamentEventReset() => _reset(event, emitter),
      },
    );
  }

  Future<void> _start(DraftTournamentEventStart event, Emitter<DraftTournamentState> emit) async {
    try {
      final allPlayers = await _repository.cardsGet();
      final allTeams = await _repository.countriesGet();

      // 8 матчей (16 команд без повторов). 15 случайных команд, 1 команда пользователя
      final random = Random();

      final tournamentTeams = <CountryModel>[];

      while (tournamentTeams.length < 15) {
        final team = allTeams[random.nextInt(allTeams.length)];
        if (!tournamentTeams.contains(team)) {
          tournamentTeams.add(team);
        }
      }

      final gameTeams = <FootballTeamGameModel>[];
      for (final team in tournamentTeams) {
        final teamPlayers = allPlayers.where((p) => p.countryId == team.id).toList();

        // random scheme
        final scheme = FootballSchemes.vertical.keys.toList()[random.nextInt(FootballSchemes.vertical.length)];
        final verticalPofs = FootballSchemes.vertical[scheme] ?? [];
        final horizontalPofs = verticalPofs
            .map((pof) => FootballPlayerPositionOnField(pof.id, pof.abstractPosition, pof.y, pof.x))
            .toList();

        final startingSquad = <FootballPlayerPositionOnField, FootballPlayerCardModel>{};

        final usedPlayers = <FootballPlayerCardModel>{};

        for (final pof in horizontalPofs) {
          FootballPlayerCardModel? bestCandidate;

          // Функция для поиска лучшего кандидата с определенным условием
          FootballPlayerCardModel? findBestCandidate(bool Function(FootballPlayerCardModel) condition) {
            FootballPlayerCardModel? candidate;
            double bestRating = -1;

            for (final player in teamPlayers) {
              if (usedPlayers.contains(player)) {
                continue;
              }
              if (condition(player)) {
                final rating =
                    ratings[player.playerId]?["overall"] ??
                    60; // FootballPlayerStatsCalculator.calculateStats(player).rating;
                if (rating > bestRating) {
                  bestRating = rating;
                  candidate = player;
                }
              }
            }
            return candidate;
          }

          // Поиск в порядке приоритета:
          // 1. Точное соответствие или weight > 0.7
          bestCandidate = findBestCandidate((player) {
            if (FootballPlayerAbstractPosition.fromString(player.position) == pof.abstractPosition) {
              return true;
            }
            final weight = PositionWeights.getWeight(
              pof.abstractPosition,
              FootballPlayerAbstractPosition.fromString(player.position),
            );
            return weight > 0.7;
          });

          // 2. Weight >= 0.5
          bestCandidate ??= findBestCandidate((player) {
            final weight = PositionWeights.getWeight(
              pof.abstractPosition,
              FootballPlayerAbstractPosition.fromString(player.position),
            );
            return weight >= 0.5;
          });

          // 3. Любой свободный игрок
          bestCandidate ??= findBestCandidate((player) => true);

          if (bestCandidate != null) {
            startingSquad[pof] = bestCandidate;
            usedPlayers.add(bestCandidate);
          }
        }

        // if (startingSquad.length < 11) {
        //   // TODO в некоторых командах оказывается меньше 11 игроков
        //   LogService.error("Not enough players", startingSquad.length);
        // }

        final players = <FootballPlayerInTeamGameModel>[];
        for (var i = 0; i < startingSquad.entries.length; i++) {
          final pof = startingSquad.entries.toList()[i].key;
          final pc = startingSquad.entries.toList()[i].value;
          final stats = ratings[pc.playerId]; // FootballPlayerStatsCalculator.calculateStats(pc);

          final player = FootballPlayerInTeamGameModel(
            teamId: team.id,
            number: horizontalPofs.indexOf(pof) + 1,
            pof: pof,
            data: FootballPlayerGameModel(
              id: "${team.id}_${pc.playerId}", // TODO ADD TEAM PREFIX
              card: pc,
              stats: FootballPlayerStats(
                maxSpeed: stats?["maxSpeed"] ?? 0,
                lowPass: stats?["lowPass"] ?? 0,
                shoots: stats?["shoots"] ?? 0,
                defence: stats?["defence"] ?? 0,
                dribbling: stats?["dribbling"] ?? 0,
                goalkeeper: stats?["goalkeeper"] ?? 0,
              ),
            ),
          );

          players.add(player);
        }

        final captainId = players.random().data.card.playerId;

        gameTeams.add(
          FootballTeamGameModel(
            id: team.id,
            name: team.name,
            scheme: scheme,
            color: shirtColorByCountryName(team.name) ?? Colors.white,
            players: players,
            captainId: captainId,
          ),
        );
      }

      final draftTournament = DraftTournamentModel(
        name: "Draft Tournament",
        allRounds: [
          DraftTournamentRoundModel(
            stage: DraftTournamentStage.roundOf16,
            matches: [
              for (int i = 0; i < 8; i++)
                DraftTournamentMatchModel(teamA: gameTeams[i], teamB: i < 7 ? gameTeams[i] : event.userTeam),
            ],
          ),
          DraftTournamentRoundModel(
            stage: DraftTournamentStage.quarterfinal,
            matches: [for (int i = 0; i < 4; i++) DraftTournamentMatchModel(teamA: null, teamB: null)],
          ),
          DraftTournamentRoundModel(
            stage: DraftTournamentStage.semifinal,
            matches: [for (int i = 0; i < 2; i++) DraftTournamentMatchModel(teamA: null, teamB: null)],
          ),
          DraftTournamentRoundModel(
            stage: DraftTournamentStage.$final,
            matches: [DraftTournamentMatchModel(teamA: null, teamB: null)],
          ),
        ],
      );

      emit(DraftTournamentStateProgress(draftTournament, DraftTournamentStage.roundOf16));
    } catch (e) {
      LogService.error(e.toString(), e);
    }
  }

  Future<void> _nextMatch(DraftTournamentEventNextMatch event, Emitter<DraftTournamentState> emit) async {
    final playedMatch = event.playedMatch;
    final stage = state.stage;
    final tournament = state.tournament;

    if (stage == null || tournament == null) {
      return;
    }

    final round = tournament.allRounds.firstWhere((round) => round.stage == stage);

    final matchesToCalculate = round.matches
        .where(
          (match) =>
              match.teamA?.id != playedMatch.teamA?.id &&
              match.teamB?.id != playedMatch.teamB?.id &&
              match.teamA?.id != playedMatch.teamB?.id &&
              match.teamB?.id != playedMatch.teamA?.id,
        )
        .toList();

    // TODO: calculate matches not random
    final calculatedMatches = matchesToCalculate.map((match) {
      final teamAScore = random.nextInt(5);
      int teamBScore = 0;
      do {
        teamBScore = random.nextInt(5);
      } while (teamBScore == teamAScore);

      return DraftTournamentMatchModel(
        teamA: match.teamA,
        teamB: match.teamB,
        teamAScore: teamAScore,
        teamBScore: teamBScore,
      );
    }).toList();

    final nextStageTeams = [];

    if ((event.playedMatch.teamAScore ?? 0) > (event.playedMatch.teamBScore ?? 0)) {
      nextStageTeams.add(event.playedMatch.teamA);
    } else if ((event.playedMatch.teamAScore ?? 0) < (event.playedMatch.teamBScore ?? 0)) {
      nextStageTeams.add(event.playedMatch.teamB);
    }
    for (final match in calculatedMatches) {
      if ((match.teamAScore ?? 0) > (match.teamBScore ?? 0)) {
        nextStageTeams.add(match.teamA);
      } else if ((match.teamAScore ?? 0) < (match.teamBScore ?? 0)) {
        nextStageTeams.add(match.teamB);
      }
    }

    final nextStageMatches = <DraftTournamentMatchModel>[];

    for (int i = 0; i < nextStageTeams.length; i = i + 2) {
      nextStageMatches.add(DraftTournamentMatchModel(teamA: nextStageTeams[i], teamB: nextStageTeams[i + 1]));
    }

    final nextStage = DraftTournamentStage.values[stage.index + 1];

    emit(
      DraftTournamentStateProgress(
        DraftTournamentModel(
          name: tournament.name,
          allRounds: tournament.allRounds.map((round) {
            if (round.stage == stage) {
              // прошедший раунд
              return DraftTournamentRoundModel(stage: stage, matches: [playedMatch, ...calculatedMatches]);
            } else if (round.stage == nextStage) {
              // следующий раунд
              return DraftTournamentRoundModel(stage: nextStage, matches: nextStageMatches);
            } else {
              // остальное
              return round;
            }
          }).toList(),
        ),
        nextStage,
      ),
    );

    // TODO TEST THIS SHIT
  }

  Future<void> _reset(DraftTournamentEventReset event, Emitter<DraftTournamentState> emit) async {
    emit(DraftTournamentStateInitial());
  }
}
