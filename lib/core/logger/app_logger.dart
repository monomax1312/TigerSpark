import 'dart:developer' as dev;

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

abstract class AppLogger {
  void debug(String message, {String? tag, Object? error, StackTrace? stackTrace});
  void info(String message, {String? tag});
  void warning(String message, {String? tag, Object? error, StackTrace? stackTrace});
  void error(String message, {String? tag, Object? error, StackTrace? stackTrace});

  void logError(
    Object error, {
    String? message,
    String? tag,
    StackTrace? stackTrace,
    bool doRethrow = false,
  }) {
    final st = stackTrace ?? StackTrace.current;
    this.error(
      message ?? error.toString(),
      tag: tag,
      error: error,
      stackTrace: st,
    );
    if (doRethrow) {
      throw error;
    }
  }
}

class AppLoggerImpl extends AppLogger {
  AppLoggerImpl({this.minLevel = LogLevel.debug, this.includeStackInError = true});

  final LogLevel minLevel;
  final bool includeStackInError;

  static const String _tagPrefix = 'TigerSpark';

  bool _shouldLog(LogLevel level) {
    return level.index >= minLevel.index;
  }

  String _format(String message, {String? tag, LogLevel level = LogLevel.info}) {
    final time = DateTime.now().toIso8601String();
    final t = tag != null ? '[$tag]' : '';
    return '[$time] $_tagPrefix $t [$level] $message';
  }

  void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(level)) return;
    final out = _format(message, tag: tag, level: level);
    switch (level) {
      case LogLevel.debug:
        dev.log(message, name: tag ?? _tagPrefix);
        break;
      case LogLevel.info:
        // ignore: avoid_print
        print(out);
        break;
      case LogLevel.warning:
        // ignore: avoid_print
        print(out);
        if (error != null) {
          // ignore: avoid_print
          print('  Error: $error');
        }
        break;
      case LogLevel.error:
        // ignore: avoid_print
        print(out);
        if (error != null) {
          // ignore: avoid_print
          print('  Error: $error');
        }
        if (includeStackInError && stackTrace != null) {
          // ignore: avoid_print
          print(stackTrace);
        }
        break;
    }
  }

  @override
  void debug(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  @override
  void info(String message, {String? tag}) {
    _log(LogLevel.info, message, tag: tag);
  }

  @override
  void warning(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  @override
  void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, tag: tag, error: error, stackTrace: stackTrace);
  }
}
