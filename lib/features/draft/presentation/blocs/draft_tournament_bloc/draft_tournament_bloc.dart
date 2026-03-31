import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/draft/domain/models/position.dart';
import 'package:football_collection/features/football_cards/data/football_players_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../services/log/log_service.dart';
import '../../../../football_cards/domain/models/player.dart';
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
  final CommonFootballRepository _repository;
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
      final allPlayers = await _repository.playersGet();
      final allTeams = await _repository.teamsGet();

      final random = Random();
      final gameTeams = <FootballTeamGameModel>[];

      // Собираем ВСЕ команды, у которых достаточно игроков
      final eligibleTeams = <FootballNationalTeamModel>[];
      for (final team in allTeams) {
        final teamPlayers = allPlayers.where((p) => p.teamId == team.id).toList();
        if (teamPlayers.length >= 11) {
          eligibleTeams.add(team);
        }
      }

      // Перемешиваем список eligibleTeams
      eligibleTeams.shuffle(random);

      // Формируем составы для команд, пока не наберем 15 валидных команд
      for (final team in eligibleTeams) {
        if (gameTeams.length >= 15) break; // Уже набрали достаточно команд

        final teamPlayers = allPlayers.where((p) => p.teamId == team.id).toList();

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
                final rating = ratings[player.playerId]?["overall"] ?? 60;
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

        // Если набралось меньше 11 игроков, пропускаем команду
        if (startingSquad.length < 11) {
          continue; // Пропускаем эту команду
        }

        final players = <FootballPlayerInTeamGameModel>[];
        for (var i = 0; i < startingSquad.entries.length; i++) {
          final pof = startingSquad.entries.toList()[i].key;
          final pc = startingSquad.entries.toList()[i].value;
          final stats = ratings[pc.playerId];

          final player = FootballPlayerInTeamGameModel(
            teamId: team.id,
            number: horizontalPofs.indexOf(pof) + 1,
            pof: pof,
            data: FootballPlayerGameModel(
              id: "${team.id}_${pc.playerId}",
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

      // Проверяем, что набралось достаточно команд для турнира
      if (gameTeams.length < 15) {
        LogService.error("Not enough valid teams for tournament", gameTeams.length);
        // Здесь можно добавить обработку ошибки
        return;
      }

      // Берем первые 15 команд (они уже перемешаны)
      final tournamentTeams = gameTeams.take(15).toList();

      final draftTournament = DraftTournamentModel(
        name: "Draft Tournament",
        allRounds: [
          DraftTournamentRoundModel(
            stage: DraftTournamentStage.roundOf16,
            matches: [
              for (int i = 0; i < 8; i++)
                DraftTournamentMatchModel(
                  teamA: tournamentTeams[i],
                  teamB: i < 7 ? tournamentTeams[i + 8] : event.userTeam,
                ),
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

    // Функция для расчета силы команды
    double calculateTeamStrength(FootballTeamGameModel? team) {
      if (team == null) return 0.0;

      double totalRating = 0.0;
      int playerCount = 0;

      for (final player in team.players) {
        final stats = ratings[player.data.card.playerId];
        final overallRating = stats?["overall"] ?? 60.0;
        totalRating += overallRating;
        playerCount++;
      }

      return playerCount > 0 ? totalRating / playerCount : 0.0;
    }

    // Функция для расчета результата матча
    DraftTournamentMatchModel calculateMatchResult(DraftTournamentMatchModel match) {
      final teamAStrength = calculateTeamStrength(match.teamA);
      final teamBStrength = calculateTeamStrength(match.teamB);

      // Базовый расчет силы с учетом случайного фактора (от -10% до +10%)
      final randomFactor = 0.9 + random.nextDouble() * 0.2;
      final teamAFinalStrength = teamAStrength * randomFactor;
      final teamBFinalStrength = teamBStrength * (1.0 + (1.0 - randomFactor)); // Противоположный фактор для баланса

      // Разница в силе команд
      final strengthDifference = (teamAFinalStrength - teamBFinalStrength) / 10.0;

      // Базовое количество голов рассчитывается на основе средней силы команд
      final averageStrength = (teamAFinalStrength + teamBFinalStrength) / 2;
      final baseGoals = (averageStrength - 60) / 10; // Чем выше средний рейтинг, тем больше голов

      // Расчет голов с учетом разницы в силе
      int teamAScore, teamBScore;

      if (strengthDifference.abs() < 0.5) {
        // Близкие по силе команды
        final goals = (baseGoals + random.nextDouble() * 2).clamp(0, 5).round();
        if (random.nextBool()) {
          teamAScore = goals;
          teamBScore = (goals - 1 + random.nextInt(2)).clamp(0, 5);
        } else {
          teamBScore = goals;
          teamAScore = (goals - 1 + random.nextInt(2)).clamp(0, 5);
        }
      } else if (strengthDifference > 0) {
        // Команда A сильнее
        final advantage = strengthDifference.clamp(0, 3);
        teamAScore = (baseGoals + advantage + random.nextDouble() * 2).clamp(0, 5).round();
        teamBScore = (baseGoals - advantage + random.nextDouble() * 2).clamp(0, teamAScore - 1).clamp(0, 5).round();
      } else {
        // Команда B сильнее
        final advantage = (-strengthDifference).clamp(0, 3);
        teamBScore = (baseGoals + advantage + random.nextDouble() * 2).clamp(0, 5).round();
        teamAScore = (baseGoals - advantage + random.nextDouble() * 2).clamp(0, teamBScore - 1).clamp(0, 5).round();
      }

      // Гарантируем, что счет не будет одинаковым
      if (teamAScore == teamBScore) {
        if (teamAScore < 5) {
          if (teamAFinalStrength > teamBFinalStrength) {
            teamAScore++;
          } else {
            teamBScore++;
          }
        } else {
          teamAScore--;
        }
      }

      return DraftTournamentMatchModel(
        teamA: match.teamA,
        teamB: match.teamB,
        teamAScore: teamAScore,
        teamBScore: teamBScore,
      );
    }

    // Рассчитываем оставшиеся матчи
    final calculatedMatches = matchesToCalculate.map(calculateMatchResult).toList();

    final nextStageTeams = [];

    // Обрабатываем сыгранный матч
    if ((event.playedMatch.teamAScore ?? 0) > (event.playedMatch.teamBScore ?? 0)) {
      nextStageTeams.add(event.playedMatch.teamA);
    } else if ((event.playedMatch.teamAScore ?? 0) < (event.playedMatch.teamBScore ?? 0)) {
      nextStageTeams.add(event.playedMatch.teamB);
    }

    // Обрабатываем рассчитанные матчи
    for (final match in calculatedMatches) {
      if ((match.teamAScore ?? 0) > (match.teamBScore ?? 0)) {
        nextStageTeams.add(match.teamA);
      } else if ((match.teamAScore ?? 0) < (match.teamBScore ?? 0)) {
        nextStageTeams.add(match.teamB);
      }
    }

    final nextStageMatches = <DraftTournamentMatchModel>[];

    for (int i = 0; i < nextStageTeams.length; i = i + 2) {
      if (i + 1 < nextStageTeams.length) {
        nextStageMatches.add(DraftTournamentMatchModel(teamA: nextStageTeams[i], teamB: nextStageTeams[i + 1]));
      }
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
  }

  Future<void> _reset(DraftTournamentEventReset event, Emitter<DraftTournamentState> emit) async {
    emit(DraftTournamentStateInitial());
  }
}
