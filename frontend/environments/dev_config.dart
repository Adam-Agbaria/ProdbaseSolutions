class DevConfig {
  static const String API_URL =
      'http://127.0.0.1:5000'; // replace with your actual backend endpoint for development
  static const String NODE_ENV = 'development';
  static const int PORT = 3000;

  // You might not have a direct equivalent for JWT_SECRET in the frontend since it's typically used in the backend to sign and validate tokens.
  // But if you use it in any way in the frontend, add it here. If not, skip it.

  // Add any other constants that are relevant for your frontend's development configuration.
}
