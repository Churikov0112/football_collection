import 'package:intl/intl.dart';

String? parseCustomDate(String? dateString) {
  if (dateString == null) return null;
  String cleanedString = dateString.replaceAll(RegExp(r'\s*\(\d+\)\s*$'), '').trim();
  final dateTime = DateFormat('MMM d, y').parse(cleanedString);
  return DateFormat('dd.MM.yyyy').format(dateTime);
}
