import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // Import the AuthenticatedService class

class ProfitService {
  final String baseUrl;
  final User user;
  final AuthenticatedService authService; // Use AuthenticatedService here

  ProfitService({required this.baseUrl, required this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> createProfit(Map<String, dynamic> data) async {
    return authService.postRequest('/api/profits/', data);
  }

  Future<http.Response> getProfitById(String id) async {
    return authService.getRequest('/api/profits/$id');
  }

  Future<http.Response> getProfitsByUser(String userId) async {
    return authService.getRequest('/api/profits/user/$userId');
  }

  Future<http.Response> updateProfit(
      String id, Map<String, dynamic> data) async {
    return authService.putRequest('/api/profits/$id', data);
  }

  Future<http.Response> deleteProfit(String id) async {
    return authService.deleteRequest('/api/profits/$id');
  }

  Future<http.Response> getProfitsByProduct(String productId) async {
    return authService.getRequest('/api/profits/product/$productId');
  }

  Future<http.Response> getProfitsByClient(String clientId) async {
    return authService.getRequest('/api/profits/client/$clientId');
  }
}
