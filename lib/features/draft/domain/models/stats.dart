// ignore_for_file: join_return_with_assignment

import '../../../football_players/data/utils.dart';
import '../../../football_players/domain/models/player.dart';
import 'position.dart';

class FootballPlayerStats {
  final double maxSpeed; // Максимальная скорость
  final double lowPass; // Точность паса
  final double shoots; // Сила и точность ударов
  final double defence; // Навыки защиты
  final double dribbling; // Дриблинг
  final double goalkeeper; // Вратарь

  FootballPlayerStats({
    required this.maxSpeed,
    required this.lowPass,
    required this.shoots,
    required this.defence,
    required this.dribbling,
    required this.goalkeeper,
  });

  double get rating {
    double best = 0;
    for (final stat in [maxSpeed, lowPass, shoots, defence, dribbling, goalkeeper]) {
      if (stat > best) {
        best = stat;
      }
    }
    return best;
  }
}

class FootballPlayerStatsCalculator {
  static FootballPlayerStats calculateStats(FootballPlayerCardModel player) {
    final age = _calculateAge(player.birthDate);
    final position = FootballPlayerAbstractPosition.fromString(player.position);
    final marketValue = player.currentMarketValue ?? 0;
    final maxMarketValue = player.maxMarketValue ?? marketValue;
    final height = _parseHeight(player.height);
    final isRightFooted = player.foot?.toLowerCase().contains('right') ?? true;

    // Коэффициент легендарности
    final double legendFactor = maxMarketValue > marketValue * 2
        ? 1.0 + (maxMarketValue / marketValue.clamp(1, double.maxFinite)) * 0.1
        : 1.0;

    // Базовые значения характеристик с учетом легендарности
    final double maxSpeed = _calculateMaxSpeed(age, height, position) * legendFactor;
    final double lowPass = _calculateLowPass(age, marketValue, position) * legendFactor;
    final double shoots = _calculateShoots(age, marketValue, position, isRightFooted) * legendFactor;
    final double defence = _calculateDefence(age, marketValue, position) * legendFactor;
    final double dribbling = _calculateDribbling(age, marketValue, position) * legendFactor;
    final double goalkeeper = _calculateGoalkeeper(age, marketValue, position) * legendFactor;

    // Нормализация всех значений в диапазон 50-100
    return FootballPlayerStats(
      maxSpeed: _normalizeValue(maxSpeed, 50, 100),
      lowPass: _normalizeValue(lowPass, 50, 100),
      shoots: _normalizeValue(shoots, 50, 100),
      defence: _normalizeValue(defence, 50, 100),
      dribbling: _normalizeValue(dribbling, 50, 100),
      goalkeeper: _normalizeValue(goalkeeper, 50, 100),
    );
  }

  static int _calculateAge(String? birthDate) {
    try {
      if (birthDate == null) return 25;
      final parsedDate = parseCustomDate(birthDate);
      if (parsedDate == null) return 25;
      final dateParts = parsedDate.split('.');
      final birth = DateTime(int.parse(dateParts[2]), int.parse(dateParts[1]), int.parse(dateParts[0]));
      final now = DateTime.now();
      return now.year -
          birth.year -
          ((now.month < birth.month || (now.month == birth.month && now.day < birth.day)) ? 1 : 0);
    } catch (e) {
      return 25;
    }
  }

  static double _parseHeight(String? height) {
    if (height == null) return 180.0;
    final match = RegExp(r'(\d+)\s*cm').firstMatch(height);
    return match != null ? double.parse(match.group(1)!) : 180.0;
  }

  static double _calculateMaxSpeed(int age, double height, FootballPlayerAbstractPosition? position) {
    double baseSpeed = 70.0;

    if (age >= 24 && age <= 28) {
      baseSpeed += 8.0;
    } else if (age > 28) {
      baseSpeed -= (age - 28) * 0.8;
    } else {
      baseSpeed += (age - 18) * 1.0;
    }

    baseSpeed += (180 - height) * 0.15;

    switch (position) {
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
      case FootballPlayerAbstractPosition.st:
        baseSpeed += 12.0;
        break;
      case FootballPlayerAbstractPosition.lb:
      case FootballPlayerAbstractPosition.rb:
      case FootballPlayerAbstractPosition.lm:
      case FootballPlayerAbstractPosition.rm:
        baseSpeed += 8.0;
        break;
      case FootballPlayerAbstractPosition.gk:
      case FootballPlayerAbstractPosition.cb:
      case FootballPlayerAbstractPosition.dm:
        baseSpeed -= 10.0;
        break;
      default:
        baseSpeed += 3.0;
    }

    return baseSpeed;
  }

  static double _calculateLowPass(int age, int marketValue, FootballPlayerAbstractPosition? position) {
    double basePass = 75.0;

    basePass += (age - 18) * 1.2;
    if (age > 32) {
      basePass -= (age - 32) * 0.5;
    }

    basePass += (marketValue / 10000000) * 0.8;

    switch (position) {
      case FootballPlayerAbstractPosition.cm:
      case FootballPlayerAbstractPosition.am:
      case FootballPlayerAbstractPosition.dm:
        basePass += 15.0;
        break;
      case FootballPlayerAbstractPosition.lb:
      case FootballPlayerAbstractPosition.rb:
      case FootballPlayerAbstractPosition.lm:
      case FootballPlayerAbstractPosition.rm:
        basePass += 10.0;
        break;
      case FootballPlayerAbstractPosition.gk:
        basePass -= 20.0;
        break;
      case FootballPlayerAbstractPosition.st:
      case FootballPlayerAbstractPosition.cf:
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
        basePass -= 8.0;
        break;
      default:
        basePass += 5.0;
    }

    return basePass;
  }

  static double _calculateShoots(
    int age,
    int marketValue,
    FootballPlayerAbstractPosition? position,
    bool isRightFooted,
  ) {
    double baseShoot = 70.0;

    if (age >= 26 && age <= 30) {
      baseShoot += 10.0;
    } else if (age > 30) {
      baseShoot -= (age - 30) * 0.6;
    } else {
      baseShoot += (age - 18) * 1.5;
    }

    baseShoot += (marketValue / 10000000) * 1.0;

    switch (position) {
      case FootballPlayerAbstractPosition.st:
      case FootballPlayerAbstractPosition.cf:
        baseShoot += 18.0;
        break;
      case FootballPlayerAbstractPosition.am:
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
        baseShoot += 15.0;
        break;
      case FootballPlayerAbstractPosition.lm:
      case FootballPlayerAbstractPosition.rm:
      case FootballPlayerAbstractPosition.cm:
        baseShoot += 10.0;
        break;
      case FootballPlayerAbstractPosition.gk:
        baseShoot -= 25.0;
        break;
      case FootballPlayerAbstractPosition.cb:
      case FootballPlayerAbstractPosition.dm:
      case FootballPlayerAbstractPosition.lb:
      case FootballPlayerAbstractPosition.rb:
        baseShoot -= 12.0;
        break;
      default:
        baseShoot += 8.0;
    }

    return baseShoot;
  }

  static double _calculateDefence(int age, int marketValue, FootballPlayerAbstractPosition? position) {
    // Для вратарей defence должен быть низким
    if (position == FootballPlayerAbstractPosition.gk) {
      return 55.0 + (age - 18) * 0.3; // Вратари имеют базовую защиту 55-65
    }

    double baseDefence = 65.0;

    baseDefence += (age - 18) * 1.8;
    if (age > 35) {
      baseDefence -= (age - 35) * 0.6;
    }

    baseDefence += (marketValue / 10000000) * 0.6;

    switch (position) {
      case FootballPlayerAbstractPosition.cb:
        baseDefence += 25.0;
        break;
      case FootballPlayerAbstractPosition.lb:
      case FootballPlayerAbstractPosition.rb:
      case FootballPlayerAbstractPosition.dm:
        baseDefence += 20.0;
        break;
      case FootballPlayerAbstractPosition.cm:
        baseDefence += 8.0;
        break;
      case FootballPlayerAbstractPosition.lm:
      case FootballPlayerAbstractPosition.rm:
        baseDefence += 5.0;
        break;
      case FootballPlayerAbstractPosition.am:
        baseDefence += 3.0;
        break;
      case FootballPlayerAbstractPosition.st:
      case FootballPlayerAbstractPosition.cf:
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
        baseDefence -= 15.0;
        break;
      default:
        baseDefence += 5.0;
    }

    return baseDefence;
  }

  static double _calculateDribbling(int age, int marketValue, FootballPlayerAbstractPosition? position) {
    double baseDribbling = 72.0;

    if (age >= 22 && age <= 26) {
      baseDribbling += 12.0;
    } else if (age > 26) {
      baseDribbling -= (age - 26) * 0.8;
    } else {
      baseDribbling += (age - 18) * 1.8;
    }

    baseDribbling += (marketValue / 10000000) * 1.2;

    switch (position) {
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
      case FootballPlayerAbstractPosition.am:
        baseDribbling += 18.0;
        break;
      case FootballPlayerAbstractPosition.st:
      case FootballPlayerAbstractPosition.cf:
        baseDribbling += 15.0;
        break;
      case FootballPlayerAbstractPosition.lm:
      case FootballPlayerAbstractPosition.rm:
      case FootballPlayerAbstractPosition.cm:
        baseDribbling += 10.0;
        break;
      case FootballPlayerAbstractPosition.gk:
        baseDribbling -= 25.0;
        break;
      case FootballPlayerAbstractPosition.cb:
      case FootballPlayerAbstractPosition.dm:
        baseDribbling -= 15.0;
        break;
      case FootballPlayerAbstractPosition.lb:
      case FootballPlayerAbstractPosition.rb:
        baseDribbling -= 8.0;
        break;
      default:
        baseDribbling += 8.0;
    }

    return baseDribbling;
  }

  static double _calculateGoalkeeper(int age, int marketValue, FootballPlayerAbstractPosition? position) {
    // Только вратари имеют высокий goalkeeper
    if (position != FootballPlayerAbstractPosition.gk) {
      return 55.0; // Полевые игроки имеют базовый показатель
    }

    double baseGoalkeeper = 80.0;

    if (age >= 28 && age <= 35) {
      baseGoalkeeper += 15.0;
    } else if (age > 35) {
      baseGoalkeeper -= (age - 35) * 0.4;
    } else {
      baseGoalkeeper += (age - 18) * 1.5;
    }

    baseGoalkeeper += (marketValue / 5000000) * 1.0;

    return baseGoalkeeper;
  }

  static double _normalizeValue(double value, double min, double max) {
    return value.clamp(min, max);
  }
}
