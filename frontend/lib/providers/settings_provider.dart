import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/settings_service.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart';
import 'user_provider.dart'; // Import the user_provider.dart file

final settingsServiceProvider = Provider<SettingsService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return SettingsService(baseUrl: baseUrl, user: user!);
});

final createSettingsProvider = FutureProvider.autoDispose<http.Response>((ref) {
  final Map<String, dynamic> data = {}; // Your data here
  return ref.read(settingsServiceProvider).createSettings(data);
});

final getSettingsByUserProvider =
    FutureProvider.autoDispose<http.Response>((ref) {
  return ref.read(settingsServiceProvider).getSettingsByUser();
});

final updateSettingsProvider = FutureProvider.autoDispose<http.Response>((ref) {
  final Map<String, dynamic> data = {}; // Your updated data here
  return ref.read(settingsServiceProvider).updateSettings(data);
});

final deleteSettingsProvider = FutureProvider.autoDispose<http.Response>((ref) {
  return ref.read(settingsServiceProvider).deleteSettings();
});
