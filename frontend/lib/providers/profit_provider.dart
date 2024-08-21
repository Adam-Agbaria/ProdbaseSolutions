import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/profit_service.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'user_provider.dart'; // Import the user_provider.dart file

final profitServiceProvider = Provider<ProfitService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return ProfitService(baseUrl: baseUrl, user: user!);
});

final createProfitProvider = FutureProvider.family
    .autoDispose<http.Response, Map<String, dynamic>>((ref, data) {
  return ref.read(profitServiceProvider).createProfit(data);
});

final getProfitByIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, id) {
  return ref.read(profitServiceProvider).getProfitById(id);
});

final getProfitsByUserProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, userId) {
  return ref.read(profitServiceProvider).getProfitsByUser(userId);
});

final updateProfitProvider = FutureProvider.family
    .autoDispose<http.Response, UpdateProfitData>((ref, updateProfitData) {
  return ref
      .read(profitServiceProvider)
      .updateProfit(updateProfitData.id, updateProfitData.data);
});

final deleteProfitProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, id) {
  return ref.read(profitServiceProvider).deleteProfit(id);
});

final getProfitsByProductProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, productId) {
  return ref.read(profitServiceProvider).getProfitsByProduct(productId);
});

final getProfitsByClientProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, clientId) {
  return ref.read(profitServiceProvider).getProfitsByClient(clientId);
});

class UpdateProfitData {
  final String id;
  final Map<String, dynamic> data;

  UpdateProfitData({required this.id, required this.data});
}
