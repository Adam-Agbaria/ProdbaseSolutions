import 'package:http/http.dart' as http;
import '../models/user.dart';
import './request_service.dart'; // Import the AuthenticatedService class

class SettingsService {
  final String baseUrl;
  final User? user;
  final AuthenticatedService authService; // Use AuthenticatedService here

  SettingsService({required this.baseUrl, this.user})
      : authService = AuthenticatedService(baseUrl: baseUrl, user: user);

  Future<http.Response> createSettings(Map<String, dynamic> data) async {
    return authService.postRequest('/api/settings/', data);
  }

  Future<http.Response> getSettingsByUser() async {
    return authService.getRequest('/api/settings/');
  }

  Future<http.Response> updateSettings(Map<String, dynamic> data) async {
    return authService.putRequest('/api/settings/', data);
  }

  Future<http.Response> deleteSettings() async {
    return authService.deleteRequest('/api/settings/');
  }
}
