import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/transaction_service.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'user_provider.dart'; // Import the user_provider.dart file

final transactionServiceProvider = Provider<TransactionService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return TransactionService(baseUrl: baseUrl, user: user!);
});

final createTransactionProvider = FutureProvider.family
    .autoDispose<http.Response, Map<String, dynamic>>((ref, data) {
  return ref.read(transactionServiceProvider).createTransaction(data);
});

final getTransactionByIdProvider = FutureProvider.family
    .autoDispose<http.Response, String>((ref, transactionId) {
  return ref.read(transactionServiceProvider).getTransactionById(transactionId);
});

final getTransactionsByUserProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, userId) {
  return ref.read(transactionServiceProvider).getTransactionsByUser(userId);
});

final updateTransactionByIdProvider = FutureProvider.family
    .autoDispose<http.Response, UpdateTransactionData>(
        (ref, updateTransactionData) {
  return ref.read(transactionServiceProvider).updateTransactionById(
      updateTransactionData.transactionId, updateTransactionData.data);
});

final deleteTransactionByIdProvider = FutureProvider.family
    .autoDispose<http.Response, String>((ref, transactionId) {
  return ref
      .read(transactionServiceProvider)
      .deleteTransactionById(transactionId);
});

final getTransactionsByStatusProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, status) {
  return ref.read(transactionServiceProvider).getTransactionsByStatus(status);
});

final getTransactionsByClientProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, clientId) {
  return ref.read(transactionServiceProvider).getTransactionsByClient(clientId);
});

class UpdateTransactionData {
  final String transactionId;
  final Map<String, dynamic> data;

  UpdateTransactionData({required this.transactionId, required this.data});
}
