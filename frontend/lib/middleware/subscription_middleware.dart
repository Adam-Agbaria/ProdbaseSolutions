// subscription_middleware.dart
import '../models/user.dart'; // Import the User model

class SubscriptionMiddleware {
  final User? user;

  SubscriptionMiddleware(this.user);

  // Check if the user's subscription is active
  bool isSubscriptionActive() {
    if (user?.subscriptionStatus ?? false) {
      // Assuming you will add back the date checks
      if (user!.subscriptionEndDate != null) {
        return user!.subscriptionEndDate!.isAfter(DateTime.now());
      }
      return false; // Return false if subscriptionEndDate is null
    }
    return false;
  }

  // Use this method before invoking certain functionalities
  // to ensure the user is subscribed
  void ensureSubscribed() {
    if (!isSubscriptionActive()) {
      throw SubscriptionException('Subscription has expired or is inactive');
    }
  }
}

class SubscriptionException implements Exception {
  final String message;

  SubscriptionException(this.message);

  @override
  String toString() => 'SubscriptionException: $message';
}
