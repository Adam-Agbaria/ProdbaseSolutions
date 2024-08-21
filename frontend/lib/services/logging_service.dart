import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/log.dart'; // Import the Log model
import '../middleware/subscription_middleware.dart';
import '../middleware/logging_middleware.dart';
import '../middleware/error_middleware.dart';

class LoggingService {
  final String baseUrl;
  final http.Client client;
  final User user;

  LoggingService({required this.baseUrl, required this.user})
      : client = LoggingMiddleware(http.Client());

  Future<http.Response> _postRequest(
      String endpoint, Map<String, dynamic> data) async {
    // Ensure user is subscribed before making the request
    SubscriptionMiddleware(user).ensureSubscribed();

    final response =
        await client.post(Uri.parse('$baseUrl$endpoint'), body: data);

    handleApiError(response); // Handling errors

    return response;
  }

  Future<http.Response> logError(Log errorLog) async {
    return _postRequest('/logs/error', errorLog.toJson());
  }

  Future<http.Response> logActivity(Log activityLog) async {
    return _postRequest('/logs/activity', activityLog.toJson());
  }

  Future<http.Response> logTransaction(Log transactionLog) async {
    return _postRequest('/logs/transaction', transactionLog.toJson());
  }

  Future<http.Response> logSystem(Log systemLog) async {
    return _postRequest('/logs/system', systemLog.toJson());
  }

  Future<http.Response> logBackup(Log backupLog) async {
    return _postRequest('/logs/backup', backupLog.toJson());
  }

  Future<http.Response> logAuthentication(Log authLog) async {
    return _postRequest('/logs/authentication', authLog.toJson());
  }
}
