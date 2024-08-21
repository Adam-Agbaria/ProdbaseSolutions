import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // import the UnauthenticatedService class

class NetworkService {
  final String baseUrl;
  final User user;
  final UnauthenticatedService unauthService; // Use UnauthenticatedService here

  NetworkService({required this.baseUrl, required this.user})
      : unauthService = UnauthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> fetchResource(String resourceId) async {
    return unauthService.getRequest('/resources/$resourceId');
  }

  Future<http.Response> createResource(Map<String, dynamic> data) async {
    return unauthService.postRequest('/resources/', data);
  }

  Future<http.Response> updateResource(
      String resourceId, Map<String, dynamic> data) async {
    return unauthService.putRequest('/resources/$resourceId', data);
  }

  Future<http.Response> deleteResource(String resourceId) async {
    return unauthService.deleteRequest('/resources/$resourceId');
  }
}
