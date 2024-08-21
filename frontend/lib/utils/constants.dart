class Constants {
  // Define database status messages
  static const Map<String, String> dbMessages = {
    'CONNECTION_SUCCESS': 'Successfully connected to the database.',
    'CONNECTION_ERROR': 'Error connecting to the database.'
  };

  // Define authentication-related constants
  static const Map<String, dynamic> authConstants = {
    'JWT_SECRET': 'defaultSecretKey',
    'TOKEN_EXPIRATION': '1h'
  };

  static const baseUrl = 'http://localhost:5000';
  //static const baseUrl = 'mongodb+srv://prodbasesolutions1.mongodb.net';

  // Define general application messages
  static String serverStartMessage(int port) =>
      'Server is running on port $port';

  static const String serverErrorMessage = 'Server encountered an error.';

  // Define path to logs directory
  static const String logDirectory = './logs';

  // Other constants related to the app's business logic, configurations, etc. can be defined here.
}
