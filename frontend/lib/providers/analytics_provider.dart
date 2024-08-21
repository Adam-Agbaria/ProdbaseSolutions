import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/analytics_service.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'user_provider.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return AnalyticsService(baseUrl: baseUrl, user: user);
});

// Analytics Providers
final getTotalProfitsProvider =
    FutureProvider.family<http.Response, String>((ref, userId) {
  return ref.read(analyticsServiceProvider).getTotalProfits(userId);
});

final getTopProductsProvider =
    FutureProvider.family<http.Response, String>((ref, userId) {
  return ref.read(analyticsServiceProvider).getTopProducts(userId);
});

final getTopClientsProvider =
    FutureProvider.family<http.Response, String>((ref, userId) {
  return ref.read(analyticsServiceProvider).getTopClients(userId);
});

final getAverageOrderValueProvider =
    FutureProvider.family<http.Response, String>((ref, userId) {
  return ref.read(analyticsServiceProvider).getAverageOrderValue(userId);
});

final getOrderTrendProvider =
    FutureProvider.family<http.Response, String>((ref, userId) {
  return ref.read(analyticsServiceProvider).getOrderTrend(userId);
});

final getTransactionTrendProvider =
    FutureProvider.family<http.Response, String>((ref, userId) {
  return ref.read(analyticsServiceProvider).getTransactionTrend(userId);
});
