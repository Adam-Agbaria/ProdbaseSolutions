import 'dart:async';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 3,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
        printTime: true),
  );

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  // Function to save logs to a file (if needed)
  static Future<void> saveToFile(String message) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/logs.txt');

    final now = DateTime.now();
    final timestamp = now.toIso8601String();

    final logMessage = '[$timestamp] $message\n';
    await file.writeAsString(logMessage, mode: FileMode.append, flush: true);
  }
}
