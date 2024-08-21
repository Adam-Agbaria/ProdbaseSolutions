import 'package:http/http.dart' as http;

class ApiError {
  final int statusCode;
  final String message;

  ApiError({required this.statusCode, required this.message});
}

ApiError handleApiError(http.Response response) {
  String errorMessage = '';

  // A simple way to identify common errors. You might want to expand this
  // with more specific error handling based on your backend error responses.
  switch (response.statusCode) {
    case 400:
      errorMessage = 'Bad Request';
      break;
    case 401:
      errorMessage = 'Unauthorized';
      break;
    case 403:
      errorMessage = 'Forbidden';
      break;
    case 404:
      errorMessage = 'Not Found';
      break;
    case 500:
      errorMessage = 'Internal Server Error';
      break;
    default:
      errorMessage = 'Unexpected error occurred';
      break;
  }

  return ApiError(statusCode: response.statusCode, message: errorMessage);
}
