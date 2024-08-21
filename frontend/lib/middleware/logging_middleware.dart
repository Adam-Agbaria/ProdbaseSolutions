// logging_middleware.dart

import 'dart:async';
import 'package:http/http.dart' as http;

class LoggingMiddleware extends http.BaseClient {
  final http.Client _inner;

  LoggingMiddleware(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Log the request details before sending
    _logRequest(request);

    final response = await _inner.send(request);

    // Log the response details after receiving
    _logResponse(response);

    return response;
  }

  @override
  void close() {
    _inner.close();
  }

  void _logRequest(http.BaseRequest request) {
    print('Request: ${request.method} ${request.url}');
    print('Headers: ${request.headers}');
    if (request is http.Request) {
      print('Body: ${request.body}');
    }
  }

  void _logResponse(http.StreamedResponse response) {
    print('Response: ${response.statusCode} ${response.reasonPhrase}');
    print('Headers: ${response.headers}');
  }
}
