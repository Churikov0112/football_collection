import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_camera_tools/flame_camera_tools.dart';
import 'package:flutter/material.dart';

import '../../../../../../football_players/domain/models/position.dart';
import '../../../../../domain/models/player.dart';
import '../../../../../domain/models/schemes.dart';
import '../../../../../domain/models/team.dart';
import 'components/ball_component.dart';
import 'components/goal_component.dart';
import 'components/player/player_component.dart';
import 'components/score_component.dart';
import 'components/time_component.dart';

enum GameState { firstHalf, halftime, secondHalf, finished, setPiece }

class MatchGame extends FlameGame {
  // Constants
  static const double halftimeDuration = 45;
  final Vector2 fieldSize = Vector2(1000, 600);

  // Game components
  late BallComponent ball;
  late GoalComponent leftGoal;
  late GoalComponent rightGoal;

  // Game state
  final Random random = Random();
  double elapsedTime = 0;
  GameState gameState = GameState.firstHalf;

  // Teams
  final List<PlayerComponent> players = [];
  late FootballTeamGameModel teamA; // left in first half
  late FootballTeamGameModel teamB; // right in first half
  int teamAscore = 0;
  int teamBscore = 0;

  double setPieceTimer = 0.0;
  PlayerComponent? setPiecePlayer;

  @override
  Vector2 get size => fieldSize;

  final Function(int teamAscore, int teamBscore) onMatchFinished;

  MatchGame({
    required this.teamA,
    required this.teamB,
    required this.onMatchFinished,
  });

  @override
  Future<void> onLoad() async {
    _initializeGameComponents();
    _setupCamera();
    await super.onLoad();
  }

  // Initialization methods
  void _initializeGameComponents() {
    _setupField();
    _setupGoals();
    _setupBall();
    _setupTeams();
  }

  void _setupField() {
    // Основное поле
    world.add(RectangleComponent(size: fieldSize, paint: Paint()..color = const Color(0xFF1E8B3A)));

    // Добавляем разметку
    _drawFieldMarkings();
  }

  void _drawFieldMarkings() {
    final linePaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final borderPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    // 1. Бордюр вокруг поля
    world.add(
      RectangleComponent(
        size: fieldSize,
        paint: borderPaint,
      ),
    );

    // 2. Центральная линия
    world.add(
      RectangleComponent(
        position: Vector2(fieldSize.x / 2 - 1, 0),
        size: Vector2(2, fieldSize.y),
        paint: fillPaint,
      ),
    );

    // 3. Центральный круг
    const centerCircleRadius = 70.0;
    world.add(
      CircleComponent(
        anchor: Anchor.center,
        radius: centerCircleRadius,
        position: Vector2(fieldSize.x / 2, fieldSize.y / 2),
        paint: linePaint,
      ),
    );

    // 4. Центральная точка
    final centerPointPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    world.add(
      CircleComponent(
        anchor: Anchor.center,
        radius: 3.0,
        position: Vector2(fieldSize.x / 2, fieldSize.y / 2),
        paint: centerPointPaint,
      ),
    );

    // 5. Штрафные площади
    const penaltyAreaWidth = 120.0;
    const penaltyAreaHeight = 300.0;

    // Левая штрафная площадь
    world.add(
      RectangleComponent(
        position: Vector2(0, (fieldSize.y - penaltyAreaHeight) / 2),
        size: Vector2(penaltyAreaWidth, penaltyAreaHeight),
        paint: linePaint,
      ),
    );

    // Правая штрафная площадь
    world.add(
      RectangleComponent(
        position: Vector2(fieldSize.x - penaltyAreaWidth, (fieldSize.y - penaltyAreaHeight) / 2),
        size: Vector2(penaltyAreaWidth, penaltyAreaHeight),
        paint: linePaint,
      ),
    );

    // 6. Вратарские площади
    const goalAreaWidth = 50.0;
    const goalAreaHeight = 150.0;

    // Левая вратарская площадь
    world.add(
      RectangleComponent(
        position: Vector2(0, (fieldSize.y - goalAreaHeight) / 2),
        size: Vector2(goalAreaWidth, goalAreaHeight),
        paint: linePaint,
      ),
    );

    // Правая вратарская площадь
    world.add(
      RectangleComponent(
        position: Vector2(fieldSize.x - goalAreaWidth, (fieldSize.y - goalAreaHeight) / 2),
        size: Vector2(goalAreaWidth, goalAreaHeight),
        paint: linePaint,
      ),
    );

    // 7. Точки для пенальти
    const penaltySpotRadius = 3.0;

    // Левая точка пенальти
    world.add(
      CircleComponent(
        anchor: Anchor.center,
        radius: penaltySpotRadius,
        position: Vector2(penaltyAreaWidth - 30, fieldSize.y / 2),
        paint: centerPointPaint,
      ),
    );

    // Правая точка пенальти
    world.add(
      CircleComponent(
        anchor: Anchor.center,
        radius: penaltySpotRadius,
        position: Vector2(fieldSize.x - penaltyAreaWidth + 30, fieldSize.y / 2),
        paint: centerPointPaint,
      ),
    );
  }

  void _setupGoals() {
    leftGoal = GoalComponent(position: Vector2(0, size.y / 2 - 36));
    rightGoal = GoalComponent(position: Vector2(size.x - 10, size.y / 2 - 36));
    world.addAll([leftGoal, rightGoal]);
  }

  void _setupBall() {
    ball = BallComponent(position: size / 2);
    world.add(ball);
  }

  void _setupTeams() {
    _addTeams();
    _validateTeamFormation(); // Добавляем проверку формации
    _positionTeams();
    _linkPlayersToBall();
    _setInitialBallOwner();
  }

  void _setupCamera() {
    camera.smoothFollow(ball, stiffness: 0.85);
    camera.viewport.add(
      ScoreComponent(
        getScore: () => '${teamA.name}  |$teamAscore : $teamBscore|  ${teamB.name}',
      ),
    );
    camera.viewport.add(TimeComponent(getTime: () => "${elapsedTime.toStringAsFixed(0)}'"));
  }

  // Team management methods
  void _addTeams() {
    players.addAll([
      ...teamA.players.map((pit) => PlayerComponent(pit: pit)),
      ...teamB.players.map((pit) => PlayerComponent(pit: pit)),
    ]);

    world.addAll(players);
  }

  void _positionTeams() {
    final teamAplayers = players.where((p) => p.pit.teamId == teamA.id).toList();
    final teamBplayers = players.where((p) => p.pit.teamId == teamB.id).toList();

    if (isTeamOnLeftSide(teamA.id)) {
      _positionTeam(teamAplayers, true); // слева
      _positionTeam(teamBplayers, false); // справа
    } else {
      _positionTeam(teamBplayers, true); // слева
      _positionTeam(teamAplayers, false); // справа
    }
  }

  List<FootballPlayerPositionOnField> _getTeamScheme(String teamId) {
    final team = teamId == teamA.id ? teamA : teamB;
    final vertical = FootballSchemes.vertical[team.scheme] ?? [];
    final horizontal = vertical
        .map((pof) => FootballPlayerPositionOnField(pof.id, pof.abstractPosition, pof.y, pof.x))
        .toList();
    return horizontal;
  }

  void _positionTeam(List<PlayerComponent> team, bool isLeftTeam) {
    final teamModel = isLeftTeam ? teamA : teamB;
    final schemePositions = _getTeamScheme(teamModel.id); // Используем наш метод

    for (final player in team) {
      // Находим позицию игрока в схеме
      final schemePosition = schemePositions.firstWhere(
        (pos) => pos.id == player.pit.pof.id,
        orElse: () => const FootballPlayerPositionOnField('default', FootballPlayerAbstractPosition.cm, 0.5, 0.5),
      );

      // Для левой команды используем позицию как есть, для правой - зеркалим по X
      double adjustedX = isLeftTeam ? schemePosition.x : (1.0 - schemePosition.x);

      // Обеспечиваем, чтобы игроки находились на своей половине поля
      adjustedX = isLeftTeam
          ? adjustedX *
                0.5 // Левая половина поля (0-0.5)
          : 0.5 + adjustedX * 0.5; // Правая половина поля (0.5-1.0)

      final xPos = adjustedX * size.x;
      final yPos = schemePosition.y * size.y;

      // Добавляем случайный разброс
      final randomOffset = Vector2((random.nextDouble() - 0.5) * 10, (random.nextDouble() - 0.5) * 10);

      player.position = Vector2(xPos, yPos) + randomOffset;
    }
  }

  void _linkPlayersToBall() {
    for (final player in players) {
      player.assignBallRef(ball);
    }
    ball.assignPlayers(players);
  }

  void _setInitialBallOwner() {
    final firstOwner = players.random(random);
    ball.takeOwnership(firstOwner);
    final directionToCenter = (size / 2 - firstOwner.position).normalized();
    ball.position = firstOwner.position + directionToCenter * (firstOwner.radius + ball.radius + 1);
    ball.velocity = Vector2.zero();
  }

  // Game state management
  @override
  void update(double dt) {
    super.update(dt);

    if (gameState == GameState.setPiece) {
      setPieceTimer -= dt;
      if (setPieceTimer <= 0) {
        gameState = isTeamOnLeftSide(teamA.id) ? GameState.firstHalf : GameState.secondHalf;
        setPiecePlayer = null;
      }
    }

    if (gameState == GameState.finished) {
      return;
    }

    _updateGameTime(dt);
    _checkGamePhaseTransitions();
    _updateActiveGameState();
    _checkBallOutOfBounds(); // Добавленная проверка
  }

  void _checkBallOutOfBounds() {
    // Игнорировать, если мяч уже контролируется кем-то или игра не в активном состоянии
    if (ball.owner != null || gameState == GameState.halftime || gameState == GameState.setPiece) {
      return;
    }

    final ballX = ball.position.x;
    final ballY = ball.position.y;

    // Проверка выхода за боковые линии (аут)
    if (ballY <= 0 || ballY >= size.y) {
      _handleThrowIn(ballY <= 0 ? "top" : "bottom");
    }
    // Проверка выхода за линию ворот (левую или правую)
    else if (ballX <= 0) {
      _handleGoalKick(); // Удар от ворот
    } else if (ballX >= size.x) {
      _handleCornerKick(); // Угловой удар
    }
  }

  void _updateGameTime(double dt) {
    elapsedTime += dt;
  }

  void _checkGamePhaseTransitions() {
    if (gameState == GameState.firstHalf && elapsedTime >= halftimeDuration) {
      _handleHalftime();
    } else if (gameState == GameState.secondHalf && elapsedTime >= 2 * halftimeDuration && teamAscore != teamBscore) {
      _finishGame();
    }
  }

  void _updateActiveGameState() {
    if (gameState == GameState.firstHalf || gameState == GameState.secondHalf) {
      _checkGoals();
      _clampComponentsToField();
    }
  }

  void _handleHalftime() {
    gameState = GameState.halftime;
    print('🕒 Halftime! Teams will swap sides.');
    _resetForSecondHalf();
  }

  void _resetForSecondHalf() {
    gameState = GameState.secondHalf;
    _resetBallPosition();
    _resetPlayersPositions();
    _assignNewBallOwnerAfterHalftime();
  }

  void _resetBallPosition() {
    ball.position = size / 2;
    ball.velocity = Vector2.zero();
  }

  void _assignNewBallOwnerAfterHalftime() {
    final firstOwner = players.random(random);
    ball.takeOwnership(firstOwner);
    final directionToCenter = (size / 2 - firstOwner.position).normalized();
    ball.position = firstOwner.position + directionToCenter * (firstOwner.radius + ball.radius + 1);
  }

  void _finishGame() {
    gameState = GameState.finished;
    _stopAllMovement();
    print('🏁 Match finished! Final score: ${teamA.name} $teamAscore : $teamBscore ${teamB.name}');

    onMatchFinished(teamAscore, teamBscore);
  }

  void _stopAllMovement() {
    ball.velocity = Vector2.zero();
    for (final player in players) {
      player.velocity = Vector2.zero();
    }
  }

  // Goal management
  void _checkGoals() {
    if (leftGoal.isGoal(ball.position)) {
      _handleGoal(isTeamOnLeftSide(teamA.id) ? teamB.id : teamA.id);
    } else if (rightGoal.isGoal(ball.position)) {
      _handleGoal(isTeamOnLeftSide(teamA.id) ? teamA.id : teamB.id);
    }
  }

  void _handleGoal(String scoringTeamId) {
    print('⚽️ GOAL for Team $scoringTeamId!');

    if (scoringTeamId == teamA.id) {
      teamAscore++;
    } else {
      teamBscore++;
    }

    resetAfterGoal(scoringTeamId: scoringTeamId);
  }

  void resetAfterGoal({required String scoringTeamId}) {
    _resetPlayersPositions();
    _assignNewBallOwnerAfterGoal(scoringTeamId);
  }

  void _resetPlayersPositions() {
    final teamAplayers = players.where((p) => p.pit.teamId == teamA.id).toList();
    final teamBplayers = players.where((p) => p.pit.teamId == teamB.id).toList();

    final isTeamALeft = isTeamOnLeftSide(teamA.id);

    _positionTeam(teamAplayers, isTeamALeft);
    _positionTeam(teamBplayers, !isTeamALeft);
  }

  void _validateTeamFormation() {
    final teamAPlayersCount = players.where((p) => p.pit.teamId == teamA.id).length;
    final teamBPlayersCount = players.where((p) => p.pit.teamId == teamB.id).length;
    final teamASchemeCount = _getTeamScheme(teamA.id).length; // Используем наш метод
    final teamBSchemeCount = _getTeamScheme(teamB.id).length; // Используем наш метод

    if (teamAPlayersCount != teamASchemeCount) {
      print('⚠️ Warning: ${teamA.name} has $teamAPlayersCount players but scheme requires $teamASchemeCount');
    }

    if (teamBPlayersCount != teamBSchemeCount) {
      print('⚠️ Warning: ${teamB.name} has $teamBPlayersCount players but scheme requires $teamBSchemeCount');
    }
  }

  void _assignNewBallOwnerAfterGoal(String scoringTeamId) {
    final opposingTeamPlayers = players.where((p) => p.pit.teamId != scoringTeamId).toList();
    final newOwner = opposingTeamPlayers[random.nextInt(opposingTeamPlayers.length)];
    ball.takeOwnership(newOwner);

    final directionToCenter = (size / 2 - newOwner.position).normalized();
    ball.position = newOwner.position + directionToCenter * (newOwner.radius + ball.radius + 1);
  }

  void _clampComponentsToField() {
    for (final component in children.whereType<PositionComponent>()) {
      component.position.x = component.position.x.clamp(0.0, size.x);
      component.position.y = component.position.y.clamp(0.0, size.y);
    }
  }

  // Utility methods
  Vector2 getGoalPositionForTeam(String teamId) {
    return isTeamOnLeftSide(teamId) ? rightGoal.center : leftGoal.center;
  }

  bool isTeamOnLeftSide(String teamId) {
    final isFirstHalf = gameState == GameState.firstHalf;
    return teamId == teamA.id ? isFirstHalf : !isFirstHalf;
  }

  bool isOwnHalf(String teamId, Vector2 position) {
    final fieldMiddle = size.x / 2;
    final isTeamAOnLeft = gameState == GameState.firstHalf;
    final isOnLeftSide = position.x < fieldMiddle;

    return (teamId == teamA.id) ? (isTeamAOnLeft == isOnLeftSide) : (isTeamAOnLeft != isOnLeftSide);
  }

  void _handleThrowIn(String side) {
    gameState = GameState.setPiece;
    setPieceTimer = 3.0; // 3 секунды на выполнение
    print('⚽️ Аут! Вбрасывание выполняет команда ${setPiecePlayer?.pit.teamId}');

    // Найти ближайшего игрока для вбрасывания
    final throwInTeamId = ball.lastTouchedBy?.pit.teamId ?? teamA.id;
    final opposingTeamId = throwInTeamId == teamA.id ? teamB.id : teamA.id;
    setPiecePlayer = findNearestTeamPlayer(opposingTeamId, ball.position);

    // Установить мяч на позицию для вбрасывания
    ball.position = Vector2(ball.position.x.clamp(20, size.x - 20), side == "top" ? 10 : size.y - 10);
    if (setPiecePlayer != null) {
      ball.takeOwnership(setPiecePlayer!);
    }
  }

  void _handleCornerKick() {
    gameState = GameState.setPiece;
    setPieceTimer = 4.0; // 4 секунды на выполнение
    print('⚽️ Угловой! Выполняет команда ${setPiecePlayer?.pit.teamId}');

    final cornerTeamId = ball.lastTouchedBy?.pit.teamId == teamA.id ? teamB.id : teamA.id;
    setPiecePlayer = findNearestTeamPlayer(cornerTeamId, Vector2(size.x, size.y / 2));

    ball.position = Vector2(size.x - 5, ball.position.y.clamp(50, size.y - 50));

    if (setPiecePlayer != null) {
      ball.takeOwnership(setPiecePlayer!);
    }
  }

  void _handleGoalKick() {
    gameState = GameState.setPiece;
    setPieceTimer = 3.0; // 3 секунды на выполнение
    print('⚽️ Удар от ворот! Выполняет вратарь команды ${setPiecePlayer?.pit.teamId}');

    final goalKickTeamId = ball.lastTouchedBy?.pit.teamId == teamA.id ? teamB.id : teamA.id;
    setPiecePlayer = players.firstWhere(
      (p) => p.pit.teamId == goalKickTeamId && p.pit.pof.abstractPosition == FootballPlayerAbstractPosition.gk,
    );

    ball.position = Vector2(20, size.y / 2);
    if (setPiecePlayer != null) {
      ball.takeOwnership(setPiecePlayer!);
    }
  }

  PlayerComponent findNearestTeamPlayer(String teamId, Vector2 pos) {
    final teamPlayers = players.where((p) => p.pit.teamId == teamId); // Исправлено: ищем игроков своей команды
    late PlayerComponent nearest;
    double minDist = double.infinity;

    for (final p in teamPlayers) {
      final dist = (p.position - pos).length;
      if (dist < minDist) {
        minDist = dist;
        nearest = p;
      }
    }
    return nearest;
  }

  void debugPrintFormation(String teamId) {
    final team = teamId == teamA.id ? teamA : teamB;
    final scheme = _getTeamScheme(teamId); // Используем наш метод

    print('Formation for ${team.name} (${team.scheme}):');
    for (final position in scheme) {
      final playersInPosition = players.where((p) => p.pit.pof.id == position.id);
      print('${position.id}: ${playersInPosition.length} players');
    }
  }
}
