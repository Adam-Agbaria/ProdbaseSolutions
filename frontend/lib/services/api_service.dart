import 'package:http/http.dart' as http;
import '../middleware/error_middleware.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> _performRequest(
      Future<http.Response> Function() requestFunction) async {
    http.Response response = await requestFunction();
    handleApiError(response);
    return response;
  }

  // Order Routes
  Future<http.Response> createOrder(Map<String, dynamic> data) =>
      _performRequest(() => http.post(Uri.parse('$baseUrl/'), body: data));

  Future<http.Response> getOrderById(String id) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/$id')));

  Future<http.Response> getOrdersByUserId(String userId) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/user/$userId')));

  Future<http.Response> updateOrderById(String id, Map<String, dynamic> data) =>
      _performRequest(() => http.put(Uri.parse('$baseUrl/$id'), body: data));

  Future<http.Response> deleteOrderById(String id) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/$id')));

  Future<http.Response> getOrdersByStatus(String status) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/status/$status')));

  Future<http.Response> getOrdersByClientId(String clientId) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/client/$clientId')));

  Future<http.Response> updateDeliveryStatus(
          String id, Map<String, dynamic> data) =>
      _performRequest(() =>
          http.put(Uri.parse('$baseUrl/$id/delivery-status'), body: data));

  // Metrics Routes
  Future<http.Response> addMetricsForDay(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/metrics/'), body: data));

  Future<http.Response> getMetricsForDate(String date) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/metrics/$date')));

  Future<http.Response> getAllMetrics() =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/metrics/')));

  Future<http.Response> incrementMetricForDate(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/metrics/increment'), body: data));

  Future<http.Response> deleteMetricsForDate(String date) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/metrics/$date')));

  // Log Routes
  Future<http.Response> createLog(Map<String, dynamic> data) =>
      _performRequest(() => http.post(Uri.parse('$baseUrl/log/'), body: data));

  Future<http.Response> getLogById(String id) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/log/$id')));

  Future<http.Response> updateLog(String id, Map<String, dynamic> data) =>
      _performRequest(
          () => http.put(Uri.parse('$baseUrl/log/$id'), body: data));

  Future<http.Response> deleteLog(String id) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/log/$id')));

  // Client Routes
  Future<http.Response> createClient(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/client/'), body: data));

  Future<http.Response> getClientById(String id) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/client/$id')));

  Future<http.Response> updateClient(String id, Map<String, dynamic> data) =>
      _performRequest(
          () => http.put(Uri.parse('$baseUrl/client/$id'), body: data));

  Future<http.Response> deleteClient(String id) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/client/$id')));

  // Analytics Routes
  Future<http.Response> getAnalytics() =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/analytics/')));

  // Backup Routes
  Future<http.Response> createBackup(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/backup/'), body: data));

  Future<http.Response> getBackupById(String id) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/backup/$id')));

  Future<http.Response> getAllBackupsByUser(String userId) => _performRequest(
      () => http.get(Uri.parse('$baseUrl/backup/user/$userId')));

  Future<http.Response> updateBackupStatus(
          String id, Map<String, dynamic> data) =>
      _performRequest(
          () => http.put(Uri.parse('$baseUrl/backup/$id/status'), body: data));

  Future<http.Response> deleteBackup(String id) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/backup/$id')));

  // Profit Routes
  Future<http.Response> createProfit(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/profit/'), body: data));

  Future<http.Response> getProfitById(String id) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/profit/$id')));

  Future<http.Response> getProfitsByUser(String userId) => _performRequest(
      () => http.get(Uri.parse('$baseUrl/profit/user/$userId')));

  Future<http.Response> updateProfit(String id, Map<String, dynamic> data) =>
      _performRequest(
          () => http.put(Uri.parse('$baseUrl/profit/$id'), body: data));

  Future<http.Response> deleteProfit(String id) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/profit/$id')));

  Future<http.Response> getProfitsByProduct(String productId) =>
      _performRequest(
          () => http.get(Uri.parse('$baseUrl/profit/product/$productId')));

  Future<http.Response> getProfitsByClient(String clientId) => _performRequest(
      () => http.get(Uri.parse('$baseUrl/profit/client/$clientId')));

  // Recovery Routes
  Future<http.Response> backupCurrentState() =>
      _performRequest(() => http.post(Uri.parse('$baseUrl/recovery/backup')));

  Future<http.Response> recoverFromBackup(String backupId) => _performRequest(
      () => http.post(Uri.parse('$baseUrl/recovery/recover/$backupId')));

  Future<http.Response> clearDatabase() =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/recovery/clear')));

  // Settings Routes
  Future<http.Response> createSettings(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/settings/'), body: data));

  Future<http.Response> getSettingsByUser() =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/settings/')));

  Future<http.Response> updateSettings(Map<String, dynamic> data) =>
      _performRequest(
          () => http.put(Uri.parse('$baseUrl/settings/'), body: data));

  Future<http.Response> deleteSettings() =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/settings/')));

  // Storage Routes
  Future<http.Response> uploadFile(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/storage/upload'), body: data));

  Future<http.Response> downloadFile(String fileName) => _performRequest(
      () => http.get(Uri.parse('$baseUrl/storage/files/$fileName')));

  Future<http.Response> deleteFile(String fileName) => _performRequest(
      () => http.delete(Uri.parse('$baseUrl/storage/files/$fileName')));

  // Token Routes
  Future<http.Response> generateTokenForUser(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/token/generate'), body: data));

  Future<http.Response> validateToken() =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/token/validate')));

  Future<http.Response> refreshToken(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/token/refresh'), body: data));

  // Transaction Routes
  Future<http.Response> createTransaction(Map<String, dynamic> data) =>
      _performRequest(
          () => http.post(Uri.parse('$baseUrl/transaction/'), body: data));

  Future<http.Response> getTransaction(String id) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/transaction/$id')));

  Future<http.Response> getTransactionsForUser(String userId) =>
      _performRequest(
          () => http.get(Uri.parse('$baseUrl/transaction/user/$userId')));

  Future<http.Response> updateTransaction(
          String id, Map<String, dynamic> data) =>
      _performRequest(
          () => http.put(Uri.parse('$baseUrl/transaction/$id'), body: data));

  Future<http.Response> deleteTransaction(String id) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/transaction/$id')));

  Future<http.Response> getTransactionsByStatus(String status) =>
      _performRequest(
          () => http.get(Uri.parse('$baseUrl/transaction/status/$status')));

  Future<http.Response> getTransactionsForClient(String clientId) =>
      _performRequest(
          () => http.get(Uri.parse('$baseUrl/transaction/client/$clientId')));

  // User Routes
  Future<http.Response> createUser(Map<String, dynamic> data) =>
      _performRequest(() => http.post(Uri.parse('$baseUrl/user/'), body: data));

  Future<http.Response> getUser(String id) =>
      _performRequest(() => http.get(Uri.parse('$baseUrl/user/$id')));

  Future<http.Response> updateUser(String id, Map<String, dynamic> data) =>
      _performRequest(
          () => http.put(Uri.parse('$baseUrl/user/$id'), body: data));

  Future<http.Response> deleteUser(String id) =>
      _performRequest(() => http.delete(Uri.parse('$baseUrl/user/$id')));
}
