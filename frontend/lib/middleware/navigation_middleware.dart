// navigation_middleware.dart

import 'package:flutter/material.dart';

class NavigationMiddleware {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationMiddleware(this.navigatorKey);

  // Example: Navigate to a new screen by name
  void navigateTo(String routeName, {bool replace = false}) {
    if (replace) {
      navigatorKey.currentState!.pushReplacementNamed(routeName);
    } else {
      navigatorKey.currentState!.pushNamed(routeName);
    }
    _logNavigation(routeName);
  }

  // Example: Go back to the previous screen
  void navigateBack() {
    navigatorKey.currentState!.pop();
    _logNavigation('Back');
  }

  // Example: Handle a custom URL scheme
  void handleCustomURL(String url) {
    if (url.startsWith('myapp://')) {
      // Parse the URL and perform specific navigation based on it
      // For demonstration: Assume myapp://details/123 navigates to a "Details" page
      var segments = url.split('/');
      if (segments.length > 2 && segments[1] == 'details') {
        navigateTo('/details/${segments[2]}');
      }
    }
  }

  void _logNavigation(String routeName) {
    print('Navigating to: $routeName');
  }
}
