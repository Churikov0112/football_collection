import 'package:flutter/material.dart';

enum FootballPlayerAbstractRole {
  gk, // Вратарь
  back, // Защитник
  middle, // Полузащитник
  attack, // Нападающий
}

extension FootballPlayerAbstractRoleExtension on FootballPlayerAbstractRole {
  Color? get color {
    switch (this) {
      case FootballPlayerAbstractRole.gk:
        return Colors.orange;
      case FootballPlayerAbstractRole.back:
        return Colors.blue;
      case FootballPlayerAbstractRole.middle:
        return Colors.green;
      case FootballPlayerAbstractRole.attack:
        return Colors.red;
    }
  }
}
