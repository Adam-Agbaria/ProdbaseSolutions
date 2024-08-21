import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/client_service.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'user_provider.dart'; // Import the user_provider.dart file

// Client Service Provider to instantiate the ClientService
final clientServiceProvider = Provider<ClientService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return ClientService(baseUrl: baseUrl, user: user);
});

// Function to create a client
final createClientProvider =
    FutureProvider.family<http.Response, Map<String, dynamic>>((ref, data) {
  return ref.read(clientServiceProvider).createClient(data);
});

// Function to get a client by ID
final getClientByIdProvider =
    FutureProvider.family<http.Response, String>((ref, clientId) {
  return ref.read(clientServiceProvider).getClientById(clientId);
});

// Function to get clients by owner ID
final getClientsByOwnerIdProvider =
    FutureProvider.family<http.Response, String>((ref, ownerId) {
  return ref.read(clientServiceProvider).getClientsByOwnerId(ownerId);
});

// Function to update a client by ID
final updateClientByIdProvider =
    FutureProvider.family<http.Response, UpdateClientData>(
        (ref, updateClientData) {
  return ref
      .read(clientServiceProvider)
      .updateClientById(updateClientData.clientId, updateClientData.data);
});

// Function to delete a client by ID
final deleteClientByIdProvider =
    FutureProvider.family<http.Response, String>((ref, clientId) {
  return ref.read(clientServiceProvider).deleteClientById(clientId);
});

class UpdateClientData {
  final String clientId;
  final Map<String, dynamic> data;

  UpdateClientData({required this.clientId, required this.data});
}
