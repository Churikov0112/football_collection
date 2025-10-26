import 'package:flutter/material.dart';

import '../../../../../../../domain/models/player.dart';
import '../../../../../../../domain/models/team.dart';

Color _calculateContentColorFromBackground(Color background) {
  return ThemeData.estimateBrightnessForColor(background) == Brightness.light ? Colors.black : Colors.white;
}

void renderPlayer(
  Canvas canvas,
  FootballPlayerInTeamGameModel pit,
  double radius,
  FootballTeamGameModel teamA,
  FootballTeamGameModel teamB,
) {
  final shadowPaint = Paint()..color = Colors.black.withOpacity(0.25);
  canvas.drawCircle(const Offset(2, 3), radius * 0.95, shadowPaint);

  final outlinePaint = Paint()..color = Colors.black;
  canvas.drawCircle(Offset.zero, radius + 1.0, outlinePaint);

  final fillPaint = Paint()..color = pit.teamId == teamA.id ? teamA.color : teamB.color;
  canvas.drawCircle(Offset.zero, radius, fillPaint);

  final teamColor = pit.teamId == teamA.id ? teamA.color : teamB.color;
  final numberColor = _calculateContentColorFromBackground(teamColor);

  // Рендер номера игрока по центру кружочка
  final numberPainter = TextPainter(
    text: TextSpan(
      text: pit.number.toString(),
      style: TextStyle(
        color: numberColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  numberPainter.layout();
  numberPainter.paint(
    canvas,
    Offset(-numberPainter.width / 2, -numberPainter.height / 2),
  );

  // Рендер имени игрока под кружочком в две строки
  final nameLines = _splitNameIntoLines(pit.data.card.name);
  final nameStyle = TextStyle(
    color: Colors.white,
    fontSize: _calculateFontSize(nameLines),
    fontWeight: FontWeight.normal,
  );

  // Рендер первой строки
  if (nameLines.isNotEmpty) {
    final firstLinePainter = TextPainter(
      text: TextSpan(text: nameLines[0], style: nameStyle),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    firstLinePainter.layout();
    firstLinePainter.paint(
      canvas,
      Offset(-firstLinePainter.width / 2, radius + 4),
    );
  }

  // Рендер второй строки (если есть)
  if (nameLines.length > 1) {
    final secondLinePainter = TextPainter(
      text: TextSpan(text: nameLines[1], style: nameStyle),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    secondLinePainter.layout();
    secondLinePainter.paint(
      canvas,
      Offset(-secondLinePainter.width / 2, radius + 4 + 12), // 12px - высота строки
    );
  }
}

// Функция для разделения имени на две строки
List<String> _splitNameIntoLines(String fullName) {
  final parts = fullName.split(' ').where((part) => part.isNotEmpty).toList();

  if (parts.isEmpty) {
    return [''];
  }
  if (parts.length == 1) {
    return [parts[0]];
  }

  // Для 2+ слов: первое слово на первой строке, остальные на второй
  final firstLine = parts[0];
  final secondLine = parts.sublist(1).join(' '); // Объединяем оставшиеся слова без лишних пробелов

  return [firstLine, secondLine];
}

// Функция для расчета размера шрифта (10-12px)
double _calculateFontSize(List<String> lines) {
  final maxLength = lines.fold(0, (max, line) => line.length > max ? line.length : max);

  if (maxLength <= 6) {
    return 12.0;
  }
  if (maxLength <= 8) {
    return 11.0;
  }
  return 10.0;
}
