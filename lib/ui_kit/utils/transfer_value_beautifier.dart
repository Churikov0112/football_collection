String beautifyTransferValue(int amount) {
  if (amount >= 1000000) {
    double millions = amount / 1000000;
    // Округляем до двух знаков после запятой
    String millionsStr = millions.toStringAsFixed(2);
    // Убираем лишние нули, например: 1.50 -> 1.5, 1.00 -> 1
    if (millionsStr.endsWith('.00')) {
      millionsStr = millionsStr.substring(0, millionsStr.length - 3);
    } else if (millionsStr.endsWith('0')) {
      millionsStr = millionsStr.substring(0, millionsStr.length - 1);
    }
    return '€${millionsStr}m';
  } else if (amount >= 1000) {
    int thousands = amount ~/ 1000;
    return '€${thousands}k';
  } else {
    return '€$amount';
  }
}
