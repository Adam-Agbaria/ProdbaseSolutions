import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../middleware/logging_middleware.dart';
import '../middleware/error_middleware.dart';

class EncryptionService {
  final String baseUrl;
  final http.Client client;
  final User user;

  EncryptionService({required this.baseUrl, required this.user})
      : client = LoggingMiddleware(http.Client());

  Future<http.Response> _postRequest(
      String endpoint, Map<String, dynamic> data) async {
    // Ensure user is subscribed before making the request
    // SubscriptionMiddleware(user).ensureSubscribed();

    final response =
        await client.post(Uri.parse('$baseUrl$endpoint'), body: data);

    handleApiError(response); // Handling errors

    return response;
  }

  Future<http.Response> _getRequest(String endpoint) async {
    // SubscriptionMiddleware(user).ensureSubscribed();
    final response = await client.get(Uri.parse('$baseUrl$endpoint'));
    handleApiError(response);
    return response;
  }

  Future<http.Response> _putRequest(
      String endpoint, Map<String, dynamic> data) async {
    // SubscriptionMiddleware(user).ensureSubscribed();
    final response =
        await client.put(Uri.parse('$baseUrl$endpoint'), body: data);
    handleApiError(response);
    return response;
  }

  Future<http.Response> _deleteRequest(String endpoint) async {
    // SubscriptionMiddleware(user).ensureSubscribed();
    final response = await client.delete(Uri.parse('$baseUrl$endpoint'));
    handleApiError(response);
    return response;
  }

  Future<http.Response> encryptData(Map<String, dynamic> data) async {
    return _postRequest('/encryption/encrypt', data);
  }

  Future<http.Response> decryptData(String encryptedData) async {
    return _postRequest(
        '/encryption/decrypt', {'encryptedData': encryptedData});
  }
}
