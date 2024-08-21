import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import '../middleware/subscription_middleware.dart';
import '../middleware/error_middleware.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticatedService {
  final String baseUrl;
  final http.Client client;
  final User? user; // User is now nullable
  final FlutterSecureStorage storage = FlutterSecureStorage();

  AuthenticatedService({required this.baseUrl, required this.user})
      : client = http.Client();

  Future<String> getAccessToken() async {
    if (user == null) {
      throw Exception('User not found');
    }
    return await storage.read(key: 'access_token_${user!.id}') ?? '';
  }

  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    if (user == null) {
      throw Exception('User not found');
    }
    SubscriptionMiddleware(user!).ensureSubscribed();
    final token = await getAccessToken();
    final response = await client.post(
      Uri.parse('$baseUrl$endpoint'),
      body: jsonEncode(data),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', 
      },
    );
    handleApiError(response);
    return response;
  }

  Future<http.Response> getRequest(String endpoint) async {
    if (user == null) {
      throw Exception('User not found');
    }
    SubscriptionMiddleware(user!).ensureSubscribed();
    final token = await getAccessToken();
    final response = await client.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Authorization': 'Bearer $token'},
    );
    handleApiError(response);
    return response;
  }

  Future<http.Response> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    if (user == null) {
      throw Exception('User not found');
    }
    SubscriptionMiddleware(user!).ensureSubscribed();
    final token = await getAccessToken();
    final response = await client.put(
      Uri.parse('$baseUrl$endpoint'),
      body: data,
      headers: {'Authorization': 'Bearer $token'},
    );
    handleApiError(response);
    return response;
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    if (user == null) {
      throw Exception('User not found');
    }
    SubscriptionMiddleware(user!).ensureSubscribed();
    final token = await getAccessToken();
    final response = await client.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Authorization': 'Bearer $token'},
    );
    handleApiError(response);
    return response;
  }
}

class UnauthenticatedService {
  final String baseUrl;
  final http.Client client;
  final User user;

  UnauthenticatedService({required this.baseUrl, required this.user})
      : client = http.Client();

  Future<http.Response> getRequest(String endpoint) async {
    SubscriptionMiddleware(user).ensureSubscribed();
    final response = await client.get(Uri.parse('$baseUrl$endpoint'));
    handleApiError(response);
    return response;
  }

  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    SubscriptionMiddleware(user).ensureSubscribed();
    final response =
        await client.post(Uri.parse('$baseUrl$endpoint'), body: data);
    handleApiError(response);
    return response; // You may wish to handle errors here as previously defined
  }

  Future<http.Response> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    SubscriptionMiddleware(user).ensureSubscribed();
    final response =
        await client.put(Uri.parse('$baseUrl$endpoint'), body: data);
    handleApiError(response);
    return response; // You may wish to handle errors here as previously defined
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    SubscriptionMiddleware(user).ensureSubscribed();
    final response = await client.delete(Uri.parse('$baseUrl$endpoint'));
    handleApiError(response);
    return response; // You may wish to handle errors here as previously defined
  }

  // ... rest of the methods for UnauthenticatedService, each ending with handleApiError(response);
}
