import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // import the AuthenticatedService class

class AnalyticsService {
  final String baseUrl;
  final User? user; // Nullable User
  final AuthenticatedService authService; // Use AuthenticatedService here

  AnalyticsService({required this.baseUrl, this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> getTotalProfits(String userId) async {
    return authService.getRequest('/api/analytics/total-profits/$userId');
  }

  Future<http.Response> getTopProducts(String userId) async {
    return authService.getRequest('/api/analytics/top-products/$userId');
  }

  Future<http.Response> getTopClients(String userId) async {
    return authService.getRequest('/api/analytics/top-clients/$userId');
  }

  Future<http.Response> getAverageOrderValue(String userId) async {
    return authService.getRequest('/api/analytics/average-order-value/$userId');
  }

  Future<http.Response> getOrderTrend(String userId) async {
    return authService.getRequest('/api/analytics/order-trend/$userId');
  }

  Future<http.Response> getTransactionTrend(String userId) async {
    return authService.getRequest('/api/analytics/transaction-trend/$userId');
  }
}
