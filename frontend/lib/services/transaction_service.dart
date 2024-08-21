import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // import the AuthenticatedService class
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class TransactionService {
  final String baseUrl;
  final User? user;
  final AuthenticatedService authService; // Use AuthenticatedService here

  TransactionService({required this.baseUrl, this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> createTransaction(Map<String, dynamic> data) async {
    return authService.postRequest('/api/transactions/', data);
  }

  Future<http.Response> getTransactionById(String transactionId) async {
    return authService.getRequest('/api/transactions/$transactionId');
  }

  Future<http.Response> getTransactionsByUser(String userId) async {
    final response =
        await authService.getRequest('/api/transactions/user/$userId');

    if (response.statusCode == 200) {
      await storage.write(key: "transactions_$userId", value: response.body);
    }

    return response;
  }

  Future<http.Response> updateTransactionById(
      String transactionId, Map<String, dynamic> data) async {
    return authService.putRequest('/api/transactions/$transactionId', data);
  }

  Future<http.Response> deleteTransactionById(String transactionId) async {
    return authService.deleteRequest('/api/transactions/$transactionId');
  }

  Future<http.Response> getTransactionsByStatus(String status) async {
    return authService.getRequest('/api/transactions/status/$status');
  }

  Future<http.Response> getTransactionsByClient(String clientId) async {
    return authService.getRequest('/api/transactions/client/$clientId');
  }
}
