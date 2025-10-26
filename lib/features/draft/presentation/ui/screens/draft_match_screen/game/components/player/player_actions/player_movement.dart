import 'dart:ui';

import 'package:flame/components.dart';

import '../../../../../../../../../football_players/domain/models/position.dart';
import '../../../match_game.dart';
import '../player_component.dart';
import '../player_state.dart';

extension PlayerMovement on PlayerComponent {
  static const Map<FootballPlayerAbstractPosition, Offset> basePositions = {
    FootballPlayerAbstractPosition.gk: Offset(0.05, 0.5),
    FootballPlayerAbstractPosition.cb: Offset(0.25, 0.5),
    FootballPlayerAbstractPosition.rb: Offset(0.25, 0.8),
    FootballPlayerAbstractPosition.lb: Offset(0.25, 0.2),
    FootballPlayerAbstractPosition.dm: Offset(0.35, 0.5),
    FootballPlayerAbstractPosition.cm: Offset(0.45, 0.5),
    FootballPlayerAbstractPosition.am: Offset(0.55, 0.5),
    FootballPlayerAbstractPosition.lm: Offset(0.45, 0.2),
    FootballPlayerAbstractPosition.rm: Offset(0.45, 0.8),
    FootballPlayerAbstractPosition.lw: Offset(0.65, 0.2),
    FootballPlayerAbstractPosition.rw: Offset(0.65, 0.8),
    FootballPlayerAbstractPosition.cf: Offset(0.75, 0.5),
    FootballPlayerAbstractPosition.st: Offset(0.75, 0.55),
  };

  void updatePositioning(double dt) {
    positionUpdateTimer -= dt;
    if (positionUpdateTimer <= 0) {
      updateDesiredPosition();
      positionUpdateTimer = positionUpdateInterval + gameRef.random.nextDouble() * 2.0;
    }
    applyMicroAdjustments(dt);
  }

  void updateDesiredPosition() {
    final attacking = isAttackingTeam();
    final distToBall = (ball!.position - position).length;
    final secondsAhead = (0.5 + (distToBall / gameRef.size.x).clamp(0.0, 1.0)) * (attacking ? 1.0 : 0.6);
    final predictedBallPos = predictBallPosition(secondsAhead);
    final basePos = getHomePosition();
    final attackShift = calculateTacticalShift(predictedBallPos, attacking);
    final randomShift = calculateRandomPositionShift(attacking);
    desiredPosition = basePos + attackShift + randomShift;
    desiredPosition = avoidNearbyOpponents(desiredPosition);
  }

  Vector2 predictBallPosition(double secondsAhead) {
    if (ball == null) {
      return Vector2.zero();
    }
    return ball!.owner != null
        ? ball!.position + ball!.owner!.velocity * secondsAhead
        : ball!.position + ball!.velocity * secondsAhead;
  }

  void applyMicroAdjustments(double dt) {
    microMoveTimer -= dt;
    if (microMoveTimer <= 0) {
      final offset = Vector2((gameRef.random.nextDouble() - 0.5) * 4, (gameRef.random.nextDouble() - 0.5) * 4);
      desiredPosition += offset;
      microMoveTimer = 0.3 + gameRef.random.nextDouble() * 0.8;
    }
  }

  Vector2 getHomePosition() {
    final fieldSize = gameRef.size;
    final isLeft = gameRef.isTeamOnLeftSide(pit.teamId);
    final base = basePositions[pit.pof.abstractPosition] ?? const Offset(0.5, 0.5);
    double xZone = isLeft ? fieldSize.x * base.dx : fieldSize.x * (1 - base.dx);
    double yZone = fieldSize.y * base.dy;

    final samePositionPlayers = gameRef.players
        .where((p) => p.pit.teamId == pit.teamId && p.pit.pof.abstractPosition == pit.pof.abstractPosition)
        .toList();

    if (samePositionPlayers.length > 1) {
      final index = samePositionPlayers.indexOf(this);
      const offsetStep = 100.0;
      xZone += (index - (samePositionPlayers.length - 1) / 2) * offsetStep;
      yZone += (index - (samePositionPlayers.length - 1) / 2) * offsetStep;
    }

    final random = gameRef.random;
    xZone += (random.nextDouble() - 0.5) * 10;
    yZone += (random.nextDouble() - 0.5) * 10;

    return Vector2(xZone, yZone);
  }

  Vector2 calculateTacticalShift(Vector2 ballPos, bool attacking) {
    final fieldLength = gameRef.size.x;
    final fieldWidth = gameRef.size.y;
    final attackBiasX = ((ballPos.x - position.x) / fieldLength) * 120;
    final sideBiasY = ((ballPos.y - position.y) / fieldWidth) * 60;
    final nearbyEnemies = gameRef.players
        .where((p) => p.pit.teamId != pit.teamId && (p.position - ballPos).length < 50)
        .length;
    final crowdFactor = nearbyEnemies > 3 ? 0.5 : 1.0;
    final multiplier = attacking ? (teamState == TeamState.counter ? 1.4 : 1.0) : 0.3;
    return Vector2(attackBiasX * multiplier * crowdFactor, sideBiasY * multiplier * crowdFactor);
  }

  Vector2 calculateRandomPositionShift(bool attacking) {
    final random = gameRef.random;
    double xShift = 0;
    double yShift = 0;

    final shiftChance = random.nextDouble();
    final shiftThreshold = _getPositionShiftThreshold();

    if (shiftChance < shiftThreshold) {
      final isTeamOnLeft = gameRef.isTeamOnLeftSide(pit.teamId);
      xShift = attacking ? (isTeamOnLeft ? 100 : -100) : (isTeamOnLeft ? -100 : 100);

      final isWidePlayer = [
        FootballPlayerAbstractPosition.rb,
        FootballPlayerAbstractPosition.lb,
        FootballPlayerAbstractPosition.lm,
        FootballPlayerAbstractPosition.rm,
        FootballPlayerAbstractPosition.lw,
        FootballPlayerAbstractPosition.rw,
      ].contains(pit.pof.abstractPosition);

      final yRange = isWidePlayer ? 80 : 40;
      yShift = (random.nextDouble() - 0.5) * yRange;
      xShift *= _getPositionShiftMultiplier();
    }

    return Vector2(xShift, yShift);
  }

  double _getPositionShiftThreshold() {
    switch (pit.pof.abstractPosition) {
      case FootballPlayerAbstractPosition.cb:
        return 0.2;
      case FootballPlayerAbstractPosition.rb:
      case FootballPlayerAbstractPosition.lb:
        return 0.3;
      case FootballPlayerAbstractPosition.dm:
        return 0.35;
      case FootballPlayerAbstractPosition.cm:
      case FootballPlayerAbstractPosition.am:
        return 0.4;
      case FootballPlayerAbstractPosition.lm:
      case FootballPlayerAbstractPosition.rm:
        return 0.45;
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
        return 0.35;
      case FootballPlayerAbstractPosition.st:
      case FootballPlayerAbstractPosition.cf:
        return 0.15;
      default:
        return 0.3;
    }
  }

  double _getPositionShiftMultiplier() {
    switch (pit.pof.abstractPosition) {
      case FootballPlayerAbstractPosition.st:
      case FootballPlayerAbstractPosition.cf:
        return 1.5;
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
        return 1.2;
      case FootballPlayerAbstractPosition.am:
      case FootballPlayerAbstractPosition.cm:
        return 1.0;
      case FootballPlayerAbstractPosition.dm:
      case FootballPlayerAbstractPosition.cb:
        return 0.8;
      default:
        return 1.0;
    }
  }

  Vector2 avoidNearbyOpponents(Vector2 target) {
    final nearbyEnemies = gameRef.players.where((p) => p.pit.teamId != pit.teamId && (p.position - target).length < 60);
    Vector2 avoidance = Vector2.zero();
    final double crowdFactor = nearbyEnemies.length > 2 ? 1.5 : 1.0;
    for (final enemy in nearbyEnemies) {
      final away = (target - enemy.position).normalized();
      avoidance += away * 30 * crowdFactor;
    }
    return target + avoidance;
  }

  void clampPosition() {
    position.x = position.x.clamp(radius, gameRef.size.x - radius);
    position.y = position.y.clamp(radius, gameRef.size.y - radius);
  }

  Vector2 avoidSetPieceZone(Vector2 target) {
    if (gameRef.gameState == GameState.setPiece && pit.teamId != gameRef.setPiecePlayer?.pit.teamId) {
      final toBall = gameRef.ball.position - position;
      if (toBall.length < 100) {
        return target - toBall.normalized() * 50;
      }
    }
    return target;
  }

  void moveToOpenSpace() {
    final adjustedTarget = avoidSetPieceZone(desiredPosition);
    final toTarget = adjustedTarget - position;

    if (gameRef.gameState == GameState.finished || gameRef.gameState == GameState.setPiece) {
      // Если сейчас стандартное положение, противники должны стоять на месте
      if (pit.teamId != gameRef.setPiecePlayer?.pit.teamId) {
        velocity = Vector2.zero();
        return;
      }
    }

    // final toTarget = desiredPosition - position;
    if (toTarget.length > 4) {
      final speed = isAttackingTeam() ? pit.data.stats.maxSpeed * 0.6 : pit.data.stats.maxSpeed * 0.4;
      velocity = toTarget.normalized() * speed;
      position += velocity * deltaTime;

      final nearbyTeammates = gameRef.players.where(
        (p) => p.pit.teamId == pit.teamId && p != this && (p.position - position).length < 30,
      );
      for (final t in nearbyTeammates) {
        final away = (position - t.position).normalized() * 10;
        position += away * deltaTime;
      }
    } else {
      velocity = Vector2.zero();
    }
  }
}
