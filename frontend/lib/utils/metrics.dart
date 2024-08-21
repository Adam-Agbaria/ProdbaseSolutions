import 'package:flutter/material.dart';

class MetricsUtil {
  // Gets screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // Gets screen width
  static double getScreenWidth(BuildContext context) {
    return getScreenSize(context).width;
  }

  // Gets screen height
  static double getScreenHeight(BuildContext context) {
    return getScreenSize(context).height;
  }

  // Gets the device pixel ratio (useful for image quality)
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  // Determines if the device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return getScreenSize(context).width > getScreenSize(context).height;
  }

  // Determines if the device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return !isLandscape(context);
  }

  // Get the system brightness mode (light or dark theme)
  static Brightness getSystemBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

  // Check if the system theme is dark
  static bool isDarkMode(BuildContext context) {
    return getSystemBrightness(context) == Brightness.dark;
  }

  // Check if the system theme is light
  static bool isLightMode(BuildContext context) {
    return !isDarkMode(context);
  }
}
