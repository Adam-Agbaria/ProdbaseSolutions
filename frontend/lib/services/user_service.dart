import 'package:http/http.dart' as http;
import '../middleware/logging_middleware.dart';
import '../middleware/error_middleware.dart';

class UserService {
  final String baseUrl;
  final http.Client client;

  UserService({required this.baseUrl})
      : client = LoggingMiddleware(http.Client());

  Future<http.Response> _postRequest(
      String endpoint, Map<String, dynamic> data) async {
    final response =
        await client.post(Uri.parse('$baseUrl$endpoint'), body: data);
    handleApiError(response);
    return response;
  }

  Future<http.Response> _getRequest(String endpoint) async {
    final response = await client.get(Uri.parse('$baseUrl$endpoint'));
    handleApiError(response);
    return response;
  }

  Future<http.Response> _putRequest(
      String endpoint, Map<String, dynamic> data) async {
    final response =
        await client.put(Uri.parse('$baseUrl$endpoint'), body: data);
    handleApiError(response);
    return response;
  }

  Future<http.Response> _deleteRequest(String endpoint) async {
    final response = await client.delete(Uri.parse('$baseUrl$endpoint'));
    handleApiError(response);
    return response;
  }

  Future<http.Response> createUser(Map<String, dynamic> data) async {
    return _postRequest('/api/user/', data);
  }

  Future<http.Response> getUserById(String userId) async {
    return _getRequest('/api/user/$userId');
  }

  Future<http.Response> updateUserById(
      String userId, Map<String, dynamic> data) async {
    return _putRequest('/api/user/$userId', data);
  }

  Future<http.Response> deleteUserById(String userId) async {
    return _deleteRequest('/user/$userId');
  }
}
