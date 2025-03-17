import 'package:logger/logger.dart';

class LogService {
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void log(String message) {
    _logger.d(message, time: DateTime.now());
  }

  static void error(String message, Object error) {
    _logger.e(message, time: DateTime.now(), error: error);
  }
}
