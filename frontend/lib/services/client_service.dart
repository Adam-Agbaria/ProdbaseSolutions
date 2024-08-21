import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // import the AuthenticatedService class

class ClientService {
  final String baseUrl;
  final User? user;
  final AuthenticatedService authService; // Use AuthenticatedService here

  ClientService({required this.baseUrl, this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> createClient(Map<String, dynamic> data) async {
    return authService.postRequest('/api/clients/', data);
  }

  Future<http.Response> getClientById(String clientId) async {
    return authService.getRequest('/api/clients/$clientId');
  }

  Future<http.Response> getClientsByOwnerId(String ownerId) async {
    return authService.getRequest('/api/clients/owner/$ownerId');
  }

  Future<http.Response> updateClientById(
      String clientId, Map<String, dynamic> data) async {
    return authService.putRequest('/api/clients/$clientId', data);
  }

  Future<http.Response> deleteClientById(String clientId) async {
    return authService.deleteRequest('/api/clients/$clientId');
  }
}
