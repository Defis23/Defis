
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLogger {
  static const String _name = 'ROBSPACE';

  static void debug(String message) {
    _log('DEBUG', message, 500);
  }

  static void info(String message) {
    _log('INFO', message, 800);
  }

  static void warning(String message) {
    _log('WARNING', message, 900);
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final logMessage = '[$_name][ERROR] $message';

    debugPrint(logMessage);
    if (error != null) {
      debugPrint('Error: $error');
    }
    if (stackTrace != null) {
      debugPrint('$stackTrace');
    }

    developer.log(
      message,
      name: _name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _log(String levelName, String message, int level) {
    final logMessage = '[$_name][$levelName] $message';

    debugPrint(logMessage);

    developer.log(
      message,
      name: _name,
      level: level,
    );
  }
}
