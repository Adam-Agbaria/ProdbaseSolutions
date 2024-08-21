import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'user_provider.dart'; // Import the user_provider.dart file

// Auth State Provider to track the authentication state
final authStateProvider =
    StateProvider<AuthStatus>((ref) => AuthStatus.unauthenticated);

enum AuthStatus {
  authenticated,
  unauthenticated,
  authenticating,
}

// Auth Service Provider to instantiate the AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  final baseUrl = Constants.baseUrl;
  final userAsyncValue = ref.watch(userProvider);

  User? user;
  userAsyncValue.when(
    data: (data) => user = data,
    loading: () => user = null, // Handle loading state
    error: (error, stack) => user = null, // Handle error state
  );

  return AuthService(baseUrl: baseUrl, user: user);
});

// User Provider to provide user information
// This is now replaced by the userProvider in user_provider.dart

// Function to perform user registration
final registerUserProvider = FutureProvider.family
    .autoDispose<http.Response, Map<String, dynamic>>((ref, data) {
  return ref.read(authServiceProvider).registerUser(data);
});

// Function to perform user login
final loginUserProvider = FutureProvider.family
    .autoDispose<http.Response, Map<String, dynamic>>((ref, data) {
  return ref.read(authServiceProvider).loginUser(data);
});

// Function to perform user logout
final logoutUserProvider = FutureProvider.autoDispose<http.Response>((ref) {
  return ref.read(authServiceProvider).logoutUser();
});

// Function to send a verification code
final sendVerificationCodeProvider =
    FutureProvider.family.autoDispose<http.Response, String>((ref, email) {
  return ref.read(authServiceProvider).sendVerificationCode(email);
});

// Function to verify the code and change the password
final verifyAndChangePasswordProvider = FutureProvider.family
    .autoDispose<http.Response, Map<String, dynamic>>((ref, data) {
  final email = data['email'] as String;
  final code = data['code'] as String;
  final newPassword = data['newPassword'] as String;
  return ref
      .read(authServiceProvider)
      .verifyAndChangePassword(email, code, newPassword);
});
