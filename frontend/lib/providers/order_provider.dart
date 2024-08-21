import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/order_service.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'user_provider.dart'; // Import the user_provider.dart file

final orderServiceProvider = Provider<OrderService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return OrderService(baseUrl: baseUrl, user: user);
});

final createOrderProvider = FutureProvider.family
    .autoDispose<http.Response, Map<String, dynamic>>((ref, data) {
  return ref.read(orderServiceProvider).createOrder(data);
});

final getOrderByIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, orderId) {
  return ref.read(orderServiceProvider).getOrderById(orderId);
});

final getOrdersByUserIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, userId) {
  return ref.read(orderServiceProvider).getOrdersByUserId(userId);
});

final updateOrderByIdProvider = FutureProvider.family
    .autoDispose<http.Response, UpdateOrderData>((ref, updateOrderData) {
  return ref
      .read(orderServiceProvider)
      .updateOrderById(updateOrderData.orderId, updateOrderData.data);
});

final deleteOrderByIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, orderId) {
  return ref.read(orderServiceProvider).deleteOrderById(orderId);
});

final getOrdersByStatusProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, status) {
  return ref.read(orderServiceProvider).getOrdersByStatus(status);
});

final getOrdersByClientIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, clientId) {
  return ref.read(orderServiceProvider).getOrdersByClientId(clientId);
});

final updateDeliveryStatusProvider = FutureProvider.family
    .autoDispose<http.Response, UpdateDeliveryStatusData>(
        (ref, updateDeliveryStatusData) {
  return ref.read(orderServiceProvider).updateDeliveryStatus(
      updateDeliveryStatusData.orderId, updateDeliveryStatusData.data);
});

class UpdateOrderData {
  final String orderId;
  final Map<String, dynamic> data;

  UpdateOrderData({required this.orderId, required this.data});
}

class UpdateDeliveryStatusData {
  final String orderId;
  final Map<String, dynamic> data;

  UpdateDeliveryStatusData({required this.orderId, required this.data});
}
