import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // import the AuthenticatedService class

class OrderService {
  final String baseUrl;
  final User? user;
  final AuthenticatedService authService; // Use AuthenticatedService here

  OrderService({required this.baseUrl, this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> createOrder(Map<String, dynamic> data) async {
    return authService.postRequest(
        '/orders/', data); // use authService to call the method
  }

  Future<http.Response> getOrderById(String orderId) async {
    return authService.getRequest('/api/orders/$orderId');
  }

  Future<http.Response> getOrdersByUserId(String userId) async {
    return authService.getRequest('/api/orders/user/$userId');
  }

  Future<http.Response> updateOrderById(
      String orderId, Map<String, dynamic> data) async {
    return authService.putRequest('/api/orders/$orderId', data);
  }

  Future<http.Response> deleteOrderById(String orderId) async {
    return authService.deleteRequest('/api/orders/$orderId');
  }

  Future<http.Response> getOrdersByStatus(String status) async {
    return authService.getRequest('/api/orders/status/$status');
  }

  Future<http.Response> getOrdersByClientId(String clientId) async {
    return authService.getRequest('/api/orders/client/$clientId');
  }

  Future<http.Response> updateDeliveryStatus(
      String orderId, Map<String, dynamic> data) async {
    return authService.putRequest('/api/orders/$orderId/delivery-status', data);
  }
}
