import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // Import the AuthenticatedService class

class StorageService {
  final String baseUrl;
  final User user;
  final AuthenticatedService authService; // Use AuthenticatedService here

  StorageService({required this.baseUrl, required this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> uploadFile(Map<String, dynamic> formData) async {
    return authService.postRequest('/upload', formData);
  }

  Future<http.Response> downloadFile(String fileName) async {
    return authService.getRequest('/files/$fileName');
  }

  Future<http.Response> deleteFile(String fileName) async {
    return authService.deleteRequest('/files/$fileName');
  }
}
