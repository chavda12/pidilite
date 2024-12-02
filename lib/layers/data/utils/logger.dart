import 'package:logger/logger.dart';

typedef LogLevel = Level;

final _logger = Logger();

void debugLog(
  dynamic message, {
  LogLevel level = LogLevel.debug,
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  _logger.log(
    level,
    message,
    time: time,
    error: error,
    stackTrace: stackTrace,
  );
}
