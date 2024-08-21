import 'dart:convert'; // Required for json decoding
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure storage
import '../models/user.dart'; // For SubscriptionMiddleware
import '../middleware/logging_middleware.dart';
import '../middleware/error_middleware.dart';

class AuthService {
  final String baseUrl;
  final http.Client client;
  final User? user; // Nullable User
  final FlutterSecureStorage storage = FlutterSecureStorage();

  AuthService({required this.baseUrl, this.user}) // User can be null now
      : client = LoggingMiddleware(http.Client());

  Future<String?> _retrieveToken() async {
    return await storage.read(key: 'token');
  }

  Future<http.Response> _authenticatedRequest(String method, String endpoint,
      {Map<String, dynamic>? data}) async {
    if (user == null) {
      print('user not found');
      // Handle the error if user is null
      return http.Response('User not found', 400);
    }

    // Ensure user is subscribed before making the request
    // SubscriptionMiddleware(user!).ensureSubscribed();

    final token = await _retrieveToken(); // Retrieve the token
    if (token == null) {
      print("token not found");
      // Handle the error as needed
      return http.Response('Token not found', 401);
    }

    final headers = {
      'Authorization': 'Bearer $token',
    };

    var uri = Uri.parse('$baseUrl$endpoint');
    http.Response response;

    try {
      switch (method) {
        case 'POST':
          response = await client.post(uri, body: data, headers: headers);
          break;
        case 'GET':
          response = await client.get(uri, headers: headers);
          break;
        case 'PUT':
          response = await client.put(uri, body: data, headers: headers);
          break;
        case 'DELETE':
          response = await client.delete(uri, headers: headers);
          break;
        default:
          return http.Response('Method not implemented', 501);
      }

      handleApiError(response); // Handling errors
    } catch (e) {
      return http.Response('An error occurred: $e', 500);
    }

    return response;
  }

  Future<http.Response> registerUser(Map<String, dynamic> data) async {
    try {
      final response =
          await _authenticatedRequest('POST', '/auth/register', data: data);

      if (response.statusCode == 201) {
        final jsonBody = json.decode(response.body);
        final token = jsonBody['token'];
        final userId = jsonBody['user']['_id'];
        await storage.write(key: 'token', value: token);
        await storage.write(key: 'userId', value: userId);
      }
      return response;
    } catch (e) {
      return http.Response('Registration error: $e', 500);
    }
  }

  Future<http.Response> loginUser(Map<String, dynamic> data) async {
    var uri = Uri.parse('$baseUrl/api/auth/login');
    print('Debug Log: Sending this data to server: $data');
    print('Debug Log: Using this URI: $uri');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json'
        }, // Explicitly set the content type
        body: json.encode(data), // Use json.encode()
      );

      // Debug Log: Print out the HTTP response code
      print('Debug Log: Received HTTP Status Code: ${response.statusCode}');
      // Debug Log: Print out the raw HTTP response body
      // print('Debug Log: Raw HTTP Response Body: ${response.body}');

      handleApiError(response); // Handling errors

      if (response.statusCode == 200) {
        print("response 200 for login request");
        final jsonBody = json.decode(response.body);
        final token = jsonBody['token'];
        final userId = jsonBody['user']['_id'];

        // Debug Log: Print out the received token and userId
        print('Debug Log: Received token: $token');
        print('Debug Log: Received userId: $userId');

        await storage.write(key: 'token', value: token);
        await storage.write(key: 'userId', value: userId);
      } else {
        final jsonBody = json.decode(response.body);
        final serverMessage =
            jsonBody['message'] ?? 'No message provided by server';
        print("Server response: $serverMessage");
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Exception occurred: $e");
      return http.Response('Login error: $e', 500);
    }
  }

  Future<http.Response> logoutUser() async {
    if (user == null) {
      return http.Response('User not logged in', 400);
    }

    try {
      final response = await _authenticatedRequest('POST', '/api/logout');
      if (response.statusCode == 200) {
        await storage.delete(key: 'token');
        await storage.delete(key: 'userId');
      }
      return response;
    } catch (e) {
      return http.Response('Logout error: $e', 500);
    }
  }

  Future<http.Response> sendVerificationCode(String email) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/api/auth/sendVerificationCode'),
        body: {'email': email},
      );
      handleApiError(response); // Handling errors if any
      return response;
    } catch (e) {
      return http.Response('Send Verification Code error: $e', 500);
    }
  }

  Future<http.Response> verifyAndChangePassword(
      String email, String code, String newPassword) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/api/auth/verifyAndChangePassword'),
        body: {'email': email, 'code': code, 'newPassword': newPassword},
      );
      handleApiError(response); // Handling errors if any
      return response;
    } catch (e) {
      return http.Response('Verify and Change Password error: $e', 500);
    }
  }
}
