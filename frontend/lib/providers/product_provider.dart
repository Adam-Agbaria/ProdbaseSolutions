import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/product_service.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'user_provider.dart'; // Import the user_provider.dart file

final productServiceProvider = Provider<ProductService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return ProductService(baseUrl: baseUrl, user: user!);
});

final createProductProvider =
    FutureProvider.family<http.Response, Map<String, dynamic>>((ref, data) {
  return ref.read(productServiceProvider).createProduct(data);
});

final getAllProductsProvider = FutureProvider.autoDispose<http.Response>((ref) {
  return ref.read(productServiceProvider).getAllProducts();
});

final getProductByIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, productId) {
  return ref.read(productServiceProvider).getProductById(productId);
});

final updateProductByIdProvider = FutureProvider.family
    .autoDispose<http.Response, UpdateProductData>((ref, updateProductData) {
  return ref
      .read(productServiceProvider)
      .updateProductById(updateProductData.productId, updateProductData.data);
});

final deleteProductByIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, productId) {
  return ref.read(productServiceProvider).deleteProductById(productId);
});

final getProductsByOwnerIdProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, ownerId) {
  return ref.read(productServiceProvider).getProductsByOwnerId(ownerId);
});

class UpdateProductData {
  final String productId;
  final Map<String, dynamic> data;

  UpdateProductData({required this.productId, required this.data});
}
