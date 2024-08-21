import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../services/user_service.dart';
import '../models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure storage
import '../utils/constants.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(baseUrl: Constants.baseUrl);
});

final userProvider = FutureProvider<User?>((ref) async {
  try {
    final userService = ref.read(userServiceProvider);
    final userId = await storage.read(
        key: 'userId'); // Retrieve user ID from secure storage

    // print("Debug: User ID from storage - $userId"); // Debug

    if (userId == null) {
      throw Exception('User ID not found');
    }
    final response = await userService.getUserById(userId);

    // print("Debug: HTTP status - ${response.statusCode}"); // Debug
    // print("Debug: HTTP response body - ${response.body}"); // Debug
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)); // Decode JSON string
    } else {
      throw Exception('Failed to load user');
    }
  } catch (e) {
    print("Debug: Exception - $e"); // Debug
    throw Exception('An error occurred while fetching user: $e');
  }
});

final createUserProvider =
    FutureProvider.family<User, Map<String, dynamic>>((ref, userData) async {
  try {
    final userService = ref.read(userServiceProvider);
    final response = await userService.createUser(userData);

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body)); // Decode JSON string
    } else {
      throw Exception('Failed to create user');
    }
  } catch (e) {
    throw Exception('An error occurred while creating user: $e');
  }
});

final updateUserProvider = FutureProvider.family<User, Map<String, dynamic>>(
    (ref, Map<String, dynamic> updateData) async {
  try {
    final userService = ref.read(userServiceProvider);
    final userId = updateData['id'];
    final response = await userService.updateUserById(userId, updateData);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)); // Decode JSON string
    } else {
      throw Exception('Failed to update user');
    }
  } catch (e) {
    throw Exception('An error occurred while updating user: $e');
  }
});

final deleteUserProvider =
    FutureProvider.family<bool, String>((ref, String userId) async {
  try {
    final userService = ref.read(userServiceProvider);
    final response = await userService.deleteUserById(userId);

    if (response.statusCode == 200) {
      return true; // Successfully deleted
    } else {
      throw Exception('Failed to delete user');
    }
  } catch (e) {
    throw Exception('An error occurred while deleting user: $e');
  }
});
