import 'package:collection/collection.dart';

import 'player.dart';
import 'schemes.dart';

// football_scheme_connections.dart

class PositionConnectionRule {
  final String fromPositionId;
  final String toPositionId;
  final double baseChemistryMultiplier;

  PositionConnectionRule({
    required this.fromPositionId,
    required this.toPositionId,
    this.baseChemistryMultiplier = 1.0,
  });
}

class FootballSchemeConnections {
  static final Map<FootballScheme, List<PositionConnectionRule>> _connections = {
    FootballScheme.$442: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RB'),

      // Связи защитников с полузащитниками
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RST'),
      PositionConnectionRule(fromPositionId: 'RM', toPositionId: 'RST'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'LST', toPositionId: 'RST'),
    ],

    FootballScheme.$451: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RB'),

      // Связи защитников с полузащитниками
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LM'),
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'DM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'DM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'DM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'DM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RM', toPositionId: 'ST'),
    ],
    FootballScheme.$433: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RB'),

      // Связи защитников с опорником
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'CM'),

      // Связи крайних защитников с центральными полузащитниками и вингерами
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LW'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RW'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'LW'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RW'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'LW', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'ST', toPositionId: 'RW'),
    ],
    FootballScheme.$4321: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RB'),

      // Связи защитников с опорником
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RCM'),

      // Связи крайних защитников с центральными полузащитниками и вингерами
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'CM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'LAM'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'LAM'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'RAM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RAM'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'RAM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'LAM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'LAM', toPositionId: 'RAM'),
    ],
    FootballScheme.$4132: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RB'),

      // Связи защитников с опорником
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'DM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'DM'),

      // Связи крайних защитников с центральными полузащитниками и опорником
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'DM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'DM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'DM', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'DM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'DM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'CF'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'CF'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'CF', toPositionId: 'ST'),
    ],
    FootballScheme.$541: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'CB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'CB'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RB'),

      // Связи защитников с полузащитниками
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'LCM'),

      // Связи крайних защитников с центральными полузащитниками и вингерами
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LM'),
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'ST'),
    ],
    FootballScheme.$41212: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RB'),

      // Связи защитников с опорником
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'DM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'DM'),

      // Связи крайних защитников с центральными полузащитниками и опорником
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'DM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'DM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'DM', toPositionId: 'AM'),
      PositionConnectionRule(fromPositionId: 'DM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'DM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'AM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'AM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'AM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'AM', toPositionId: 'RST'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RST'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'LST', toPositionId: 'RST'),
    ],
    FootballScheme.$352: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'CB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),

      // Связи защитников с полузащитниками
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RM'),
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'AM'),
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'AM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'AM'),
      PositionConnectionRule(fromPositionId: 'RM', toPositionId: 'AM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'AM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'AM', toPositionId: 'RST'),
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'RM', toPositionId: 'RST'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'LST', toPositionId: 'RST'),
    ],
    FootballScheme.$532: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'CB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCB'),

      // Связи защитников с полузащитниками
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LCM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'CB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'CM'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'LCM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LCM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'RCM', toPositionId: 'RST'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'LST'),
      PositionConnectionRule(fromPositionId: 'CM', toPositionId: 'RST'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'LST', toPositionId: 'RST'),
    ],
    FootballScheme.$4231: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RCB'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),

      // Связи защитников с опорниками и вингерами
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LDM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LDM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RDM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RDM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'LDM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RCM'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RDM'),
      PositionConnectionRule(fromPositionId: 'LB', toPositionId: 'LW'),
      PositionConnectionRule(fromPositionId: 'RB', toPositionId: 'RW'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'LDM', toPositionId: 'AM'),
      PositionConnectionRule(fromPositionId: 'RDM', toPositionId: 'AM'),
      PositionConnectionRule(fromPositionId: 'RDM', toPositionId: 'LDM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LDM', toPositionId: 'LW'),
      PositionConnectionRule(fromPositionId: 'RDM', toPositionId: 'RW'),
      PositionConnectionRule(fromPositionId: 'AM', toPositionId: 'RW'),
      PositionConnectionRule(fromPositionId: 'AM', toPositionId: 'LW'),
      PositionConnectionRule(fromPositionId: 'AM', toPositionId: 'ST'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'LW', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RW', toPositionId: 'ST'),
    ],
    FootballScheme.$28: [
      // Связи вратаря с защитниками
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'LCB'),
      PositionConnectionRule(fromPositionId: 'GK', toPositionId: 'RCB'),

      // Защитная линия
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RCB'),

      // Связи защитников полузащитниками
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'LAM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RAM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'RM'),
      PositionConnectionRule(fromPositionId: 'RCB', toPositionId: 'LAM'),
      PositionConnectionRule(fromPositionId: 'LCB', toPositionId: 'RAM'),

      // Полузащита
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LAM'),
      PositionConnectionRule(fromPositionId: 'LAM', toPositionId: 'RAM'),
      PositionConnectionRule(fromPositionId: 'RAM', toPositionId: 'RM'),

      // Связи полузащитников с нападающими
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'LW'),
      PositionConnectionRule(fromPositionId: 'LM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'LAM', toPositionId: 'LW'),
      PositionConnectionRule(fromPositionId: 'LAM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'LAM', toPositionId: 'CF'),
      PositionConnectionRule(fromPositionId: 'RAM', toPositionId: 'CF'),
      PositionConnectionRule(fromPositionId: 'RAM', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'RAM', toPositionId: 'RW'),
      PositionConnectionRule(fromPositionId: 'RM', toPositionId: 'RW'),
      PositionConnectionRule(fromPositionId: 'RM', toPositionId: 'CF'),

      // Атакующая линия
      PositionConnectionRule(fromPositionId: 'LW', toPositionId: 'ST'),
      PositionConnectionRule(fromPositionId: 'ST', toPositionId: 'CF'),
      PositionConnectionRule(fromPositionId: 'CF', toPositionId: 'RW'),
    ],
  };

  static List<PositionConnectionRule> getConnectionsForScheme(FootballScheme scheme) {
    return _connections[scheme] ?? [];
  }

  static bool shouldConnect(
    FootballPlayerPositionOnField from,
    FootballPlayerPositionOnField to,
    FootballScheme scheme,
  ) {
    final connections = getConnectionsForScheme(scheme);

    for (final connection in connections) {
      final isDirectConnection = from.id == connection.fromPositionId && to.id == connection.toPositionId;

      final isReverseConnection = from.id == connection.toPositionId && to.id == connection.fromPositionId;

      if (isDirectConnection || isReverseConnection) {
        return true;
      }
    }

    return false;
  }

  // Вспомогательный метод для поиска позиции по id
  static FootballPlayerPositionOnField? findPositionById(
    List<FootballPlayerPositionOnField> positions,
    String id,
  ) {
    return positions.firstWhereOrNull((position) => position.id == id);
  }
}
