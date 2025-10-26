import 'player.dart';
import 'position.dart';

enum FootballScheme {
  $442,
  $451,
  $433,
  $4321,
  $4132,
  $541,
  $41212,
  $352,
  $532,
  $4231,
  $28,
  // custom,
}

extension FootballSchemeExtension on FootballScheme {
  String get humanReadable {
    switch (this) {
      case FootballScheme.$442:
        return '4-4-2';
      case FootballScheme.$451:
        return '4-5-1';
      case FootballScheme.$433:
        return '4-3-3';
      case FootballScheme.$4321:
        return '4-3-2-1';
      case FootballScheme.$4132:
        return '4-1-3-2';
      case FootballScheme.$541:
        return '5-4-1';
      case FootballScheme.$41212:
        return '4-1-2-1-2';
      case FootballScheme.$352:
        return '3-5-2';
      case FootballScheme.$532:
        return '5-3-2';
      case FootballScheme.$4231:
        return '4-2-3-1';
      case FootballScheme.$28:
        return '2-8';
      // case FootballScheme.custom:
      //   return 'Custom';
    }
  }
}

class FootballSchemes {
  static const Map<FootballScheme, List<FootballPlayerPositionOnField>> vertical = {
    FootballScheme.$442: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.15, 0.35),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.27),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.85, 0.35),
      FootballPlayerPositionOnField('LM', FootballPlayerAbstractPosition.lm, 0.15, 0.55),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.375, 0.525),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.625, 0.525),
      FootballPlayerPositionOnField('RM', FootballPlayerAbstractPosition.rm, 0.85, 0.55),
      FootballPlayerPositionOnField('LST', FootballPlayerAbstractPosition.st, 0.375, 0.8),
      FootballPlayerPositionOnField('RST', FootballPlayerAbstractPosition.st, 0.625, 0.8),
    ],
    FootballScheme.$451: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.15, 0.35),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.27),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.85, 0.35),
      FootballPlayerPositionOnField('DM', FootballPlayerAbstractPosition.dm, 0.5, 0.475),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.3, 0.575),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.7, 0.575),
      FootballPlayerPositionOnField('LM', FootballPlayerAbstractPosition.lm, 0.1, 0.65),
      FootballPlayerPositionOnField('ST', FootballPlayerAbstractPosition.st, 0.5, 0.85),
      FootballPlayerPositionOnField('RM', FootballPlayerAbstractPosition.rm, 0.9, 0.65),
    ],
    FootballScheme.$433: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.15, 0.35),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.27),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.85, 0.35),
      FootballPlayerPositionOnField('CM', FootballPlayerAbstractPosition.cm, 0.5, 0.5),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.25, 0.55),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.75, 0.55),
      FootballPlayerPositionOnField('LW', FootballPlayerAbstractPosition.lw, 0.15, 0.8),
      FootballPlayerPositionOnField('ST', FootballPlayerAbstractPosition.st, 0.5, 0.85),
      FootballPlayerPositionOnField('RW', FootballPlayerAbstractPosition.rw, 0.85, 0.8),
    ],
    FootballScheme.$4321: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.15, 0.35),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.27),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.85, 0.35),
      FootballPlayerPositionOnField('CM', FootballPlayerAbstractPosition.cm, 0.5, 0.5),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.25, 0.525),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.75, 0.525),
      FootballPlayerPositionOnField('LAM', FootballPlayerAbstractPosition.am, 0.35, 0.7),
      FootballPlayerPositionOnField('ST', FootballPlayerAbstractPosition.st, 0.5, 0.88),
      FootballPlayerPositionOnField('RAM', FootballPlayerAbstractPosition.am, 0.65, 0.7),
    ],
    FootballScheme.$4132: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.15, 0.35),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.27),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.85, 0.35),
      FootballPlayerPositionOnField('DM', FootballPlayerAbstractPosition.dm, 0.5, 0.425),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.25, 0.65),
      FootballPlayerPositionOnField('CM', FootballPlayerAbstractPosition.cm, 0.5, 0.6),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.75, 0.65),
      FootballPlayerPositionOnField('ST', FootballPlayerAbstractPosition.st, 0.375, 0.85),
      FootballPlayerPositionOnField('CF', FootballPlayerAbstractPosition.cf, 0.625, 0.825),
    ],
    FootballScheme.$541: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.125, 0.3),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.315, 0.27),
      FootballPlayerPositionOnField('CB', FootballPlayerAbstractPosition.cb, 0.5, 0.25),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.685, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.875, 0.3),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.375, 0.5),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.625, 0.5),
      FootballPlayerPositionOnField('LM', FootballPlayerAbstractPosition.lm, 0.15, 0.55),
      FootballPlayerPositionOnField('RM', FootballPlayerAbstractPosition.rm, 0.85, 0.55),
      FootballPlayerPositionOnField('ST', FootballPlayerAbstractPosition.st, 0.5, 0.8),
    ],
    FootballScheme.$41212: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.15, 0.35),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.27),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.85, 0.35),
      FootballPlayerPositionOnField('DM', FootballPlayerAbstractPosition.dm, 0.5, 0.425),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.25, 0.525),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.75, 0.525),
      FootballPlayerPositionOnField('AM', FootballPlayerAbstractPosition.am, 0.5, 0.65),
      FootballPlayerPositionOnField('LST', FootballPlayerAbstractPosition.st, 0.375, 0.825),
      FootballPlayerPositionOnField('RST', FootballPlayerAbstractPosition.st, 0.625, 0.825),
    ],
    FootballScheme.$352: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.09),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.3, 0.27),
      FootballPlayerPositionOnField('CB', FootballPlayerAbstractPosition.cb, 0.5, 0.25),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.7, 0.27),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.375, 0.45),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.625, 0.45),
      FootballPlayerPositionOnField('LM', FootballPlayerAbstractPosition.lm, 0.15, 0.525),
      FootballPlayerPositionOnField('RM', FootballPlayerAbstractPosition.rm, 0.85, 0.525),
      FootballPlayerPositionOnField('AM', FootballPlayerAbstractPosition.am, 0.5, 0.65),
      FootballPlayerPositionOnField('LST', FootballPlayerAbstractPosition.st, 0.375, 0.825),
      FootballPlayerPositionOnField('RST', FootballPlayerAbstractPosition.st, 0.625, 0.825),
    ],
    FootballScheme.$532: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.09),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.1, 0.3),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.3, 0.265),
      FootballPlayerPositionOnField('CB', FootballPlayerAbstractPosition.cb, 0.5, 0.25),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.7, 0.265),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.9, 0.3),
      FootballPlayerPositionOnField('CM', FootballPlayerAbstractPosition.cm, 0.5, 0.5),
      FootballPlayerPositionOnField('LCM', FootballPlayerAbstractPosition.cm, 0.25, 0.55),
      FootballPlayerPositionOnField('RCM', FootballPlayerAbstractPosition.cm, 0.75, 0.55),
      FootballPlayerPositionOnField('LST', FootballPlayerAbstractPosition.st, 0.375, 0.825),
      FootballPlayerPositionOnField('RST', FootballPlayerAbstractPosition.st, 0.625, 0.825),
    ],

    FootballScheme.$4231: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.1),
      FootballPlayerPositionOnField('LB', FootballPlayerAbstractPosition.lb, 0.15, 0.3),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.27),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.27),
      FootballPlayerPositionOnField('RB', FootballPlayerAbstractPosition.rb, 0.85, 0.3),
      FootballPlayerPositionOnField('LDM', FootballPlayerAbstractPosition.dm, 0.375, 0.475),
      FootballPlayerPositionOnField('RDM', FootballPlayerAbstractPosition.dm, 0.625, 0.475),
      FootballPlayerPositionOnField('AM', FootballPlayerAbstractPosition.am, 0.5, 0.65),
      FootballPlayerPositionOnField('LW', FootballPlayerAbstractPosition.lw, 0.15, 0.7),
      FootballPlayerPositionOnField('ST', FootballPlayerAbstractPosition.st, 0.5, 0.85),
      FootballPlayerPositionOnField('RW', FootballPlayerAbstractPosition.rw, 0.85, 0.7),
    ],
    FootballScheme.$28: [
      FootballPlayerPositionOnField('GK', FootballPlayerAbstractPosition.gk, 0.5, 0.125),
      FootballPlayerPositionOnField('LCB', FootballPlayerAbstractPosition.cb, 0.375, 0.3),
      FootballPlayerPositionOnField('RCB', FootballPlayerAbstractPosition.cb, 0.625, 0.3),
      FootballPlayerPositionOnField('LM', FootballPlayerAbstractPosition.lm, 0.15, 0.65),
      FootballPlayerPositionOnField('LAM', FootballPlayerAbstractPosition.am, 0.385, 0.65),
      FootballPlayerPositionOnField('RAM', FootballPlayerAbstractPosition.am, 0.615, 0.65),
      FootballPlayerPositionOnField('RM', FootballPlayerAbstractPosition.rm, 0.85, 0.65),
      FootballPlayerPositionOnField('LW', FootballPlayerAbstractPosition.lw, 0.15, 0.85),
      FootballPlayerPositionOnField('ST', FootballPlayerAbstractPosition.st, 0.385, 0.85),
      FootballPlayerPositionOnField('CF', FootballPlayerAbstractPosition.cf, 0.615, 0.85),
      FootballPlayerPositionOnField('RW', FootballPlayerAbstractPosition.rw, 0.85, 0.85),
    ],
  };
}
