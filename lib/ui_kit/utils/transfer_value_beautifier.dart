String beautifyTransferValue(int amount) {
  if (amount >= 1000000) {
    double millions = amount / 1000000;
    // Всегда показываем 2 знака после запятой, чтобы различить 1.5m и 1.55m
    return '€ ${millions.toStringAsFixed(2)}m';
  } else if (amount >= 1000) {
    double thousands = amount / 1000;
    // € Показываем 1 знак после запятой, чтобы различить 4.0k и 3.5k
    return '€ ${thousands.toStringAsFixed(1)}k';
  } else {
    return '€ $amount';
  }
}
