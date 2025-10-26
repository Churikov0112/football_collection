import 'role.dart';

enum FootballPlayerAbstractPosition {
  gk, // Вратарь
  cb, // Центральный защитник
  lb, // Левый защитник
  rb, // Правый защитник
  dm, // Опорный полузащитник
  cm, // Центральный полузащитник
  am, // Атакующий полузащитник
  lm, // Левый полузащитник
  rm, // Правый полузащитник
  lw, // Левый вингер
  rw, // Правый вингер
  cf, // Оттянутый форвард
  st; // форвард

  static FootballPlayerAbstractPosition? fromString(String? name) {
    switch (name) {
      case "Goalkeeper":
        return FootballPlayerAbstractPosition.gk;
      case "Centre-Back":
        return FootballPlayerAbstractPosition.cb;
      case "Left-Back":
        return FootballPlayerAbstractPosition.lb;
      case "Right-Back":
        return FootballPlayerAbstractPosition.rb;
      case "Defensive Midfield":
        return FootballPlayerAbstractPosition.dm;
      case "Central Midfield":
        return FootballPlayerAbstractPosition.cm;
      case "Attacking Midfield":
        return FootballPlayerAbstractPosition.am;
      case "Left Midfield":
        return FootballPlayerAbstractPosition.lm;
      case "Right Midfield":
        return FootballPlayerAbstractPosition.rm;
      case "Left Winger":
        return FootballPlayerAbstractPosition.lw;
      case "Right Winger":
        return FootballPlayerAbstractPosition.rw;
      case "Centre-Forward":
      case "Second Striker":
        return FootballPlayerAbstractPosition.cf;
      case "Striker":
        return FootballPlayerAbstractPosition.st;
      default:
        return null;
    }
  }

  static FootballPlayerAbstractPosition? fromShortString(String? name) {
    switch (name) {
      case "GK":
        return FootballPlayerAbstractPosition.gk;
      case "CB":
        return FootballPlayerAbstractPosition.cb;
      case "LB":
        return FootballPlayerAbstractPosition.lb;
      case "LWB":
        return FootballPlayerAbstractPosition.lb;
      case "RB":
        return FootballPlayerAbstractPosition.rb;
      case "RWB":
        return FootballPlayerAbstractPosition.rb;
      case "DM":
        return FootballPlayerAbstractPosition.dm;
      case "CDM":
        return FootballPlayerAbstractPosition.dm;
      case "CM":
        return FootballPlayerAbstractPosition.cm;
      case "AM":
        return FootballPlayerAbstractPosition.am;
      case "CAM":
        return FootballPlayerAbstractPosition.am;
      case "LM":
        return FootballPlayerAbstractPosition.lm;
      case "RM":
        return FootballPlayerAbstractPosition.rm;
      case "LW":
        return FootballPlayerAbstractPosition.lw;
      case "RW":
        return FootballPlayerAbstractPosition.rw;
      case "CF":
      case "SS":
        return FootballPlayerAbstractPosition.cf;
      case "ST":
        return FootballPlayerAbstractPosition.st;
      default:
        return null;
    }
  }
}

extension FootballPlayerAbstractPositionExtension on FootballPlayerAbstractPosition {
  String get originalName {
    switch (this) {
      case FootballPlayerAbstractPosition.gk:
        return 'Goalkeeper';
      case FootballPlayerAbstractPosition.cb:
        return 'Centre-Back';
      case FootballPlayerAbstractPosition.lb:
        return 'Left-Back';
      case FootballPlayerAbstractPosition.rb:
        return 'Right-Back';
      case FootballPlayerAbstractPosition.dm:
        return 'Defensive Midfield';
      case FootballPlayerAbstractPosition.cm:
        return 'Central Midfield';
      case FootballPlayerAbstractPosition.am:
        return 'Attacking Midfield';
      case FootballPlayerAbstractPosition.lm:
        return 'Left Midfield';
      case FootballPlayerAbstractPosition.rm:
        return 'Right Midfield';
      case FootballPlayerAbstractPosition.lw:
        return 'Left Winger';
      case FootballPlayerAbstractPosition.rw:
        return 'Right Winger';
      case FootballPlayerAbstractPosition.cf:
        return 'Centre-Forward';
      case FootballPlayerAbstractPosition.st:
        return 'Striker';
    }
  }

  FootballPlayerAbstractRole? get role {
    switch (this) {
      case FootballPlayerAbstractPosition.gk:
        return FootballPlayerAbstractRole.gk;
      case FootballPlayerAbstractPosition.cb:
      case FootballPlayerAbstractPosition.lb:
      case FootballPlayerAbstractPosition.rb:
        return FootballPlayerAbstractRole.back;
      case FootballPlayerAbstractPosition.dm:
      case FootballPlayerAbstractPosition.cm:
      case FootballPlayerAbstractPosition.am:
      case FootballPlayerAbstractPosition.lm:
      case FootballPlayerAbstractPosition.rm:
        return FootballPlayerAbstractRole.middle;
      case FootballPlayerAbstractPosition.lw:
      case FootballPlayerAbstractPosition.rw:
      case FootballPlayerAbstractPosition.cf:
      case FootballPlayerAbstractPosition.st:
        return FootballPlayerAbstractRole.attack;
    }
  }
}
