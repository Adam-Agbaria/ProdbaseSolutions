import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart'; // Import your User model here

class AuthMiddleware {
  final String baseUrl;
  final http.Client client;

  AuthMiddleware({required this.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  Future<http.Response> _postRequest(
      String endpoint, Map<String, dynamic> data) async {
    final response =
        await client.post(Uri.parse('$baseUrl$endpoint'), body: data);
    return response;
  }

  Future<User?> loginUser(String username, String password) async {
    final Map<String, dynamic> requestData = {
      'username': username,
      'password': password,
    };

    try {
      final response = await _postRequest('/auth/login', requestData);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return User.fromJson(
            responseData); // Assuming your API returns user data
      }
      return null; // Return null for unsuccessful login
    } catch (error) {
      print('Error during login: $error');
      return null; // Return null for any errors during login
    }
  }

  Future<User?> registerUser(
      String username, String password, String email) async {
    final Map<String, dynamic> requestData = {
      'username': username,
      'password': password,
      'email': email,
    };

    try {
      final response = await _postRequest('/auth/register', requestData);
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return User.fromJson(
            responseData); // Assuming your API returns user data
      }
      return null; // Return null for unsuccessful registration
    } catch (error) {
      print('Error during registration: $error');
      return null; // Return null for any errors during registration
    }
  }

  // Add more authentication-related methods as needed
}
