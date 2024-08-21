import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // import the AuthenticatedService class

class ProductService {
  final String baseUrl;
  final User user;
  final AuthenticatedService authService; // Use AuthenticatedService here

  ProductService({required this.baseUrl, required this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> createProduct(Map<String, dynamic> data) async {
    return authService.postRequest('/api/products/', data);
  }

  Future<http.Response> getAllProducts() async {
    return authService.getRequest('/api/products/');
  }

  Future<http.Response> getProductById(String productId) async {
    return authService.getRequest('/api/products/$productId');
  }

  Future<http.Response> updateProductById(
      String productId, Map<String, dynamic> data) async {
    return authService.putRequest('/api/products/$productId', data);
  }

  Future<http.Response> deleteProductById(String productId) async {
    return authService.deleteRequest('/api/products/$productId');
  }

  Future<http.Response> getProductsByOwnerId(String ownerId) async {
    return authService.getRequest('/api/products/owner/$ownerId');
  }
}
