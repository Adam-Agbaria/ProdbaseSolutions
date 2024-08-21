import 'dart:async';
import 'dart:convert'; // for utf8 encoding
import 'package:http/http.dart';

class RateLimiterMiddleware extends BaseClient {
  final Client _inner;
  final int requestLimit;
  final Duration timeWindow;
  final Map<String, int> requestCounts = {};

  RateLimiterMiddleware(this._inner,
      {this.requestLimit = 5, this.timeWindow = const Duration(minutes: 1)});

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final ip =
        request.url.host; // Or extract the client IP from headers if available
    final count = requestCounts[ip] ?? 0;

    if (count >= requestLimit) {
      // Too many requests, respond with an error
      final responseController = StreamController<List<int>>();
      responseController.add(
          utf8.encode('Rate limit exceeded')); // Convert the string to bytes
      responseController.close();

      return StreamedResponse(
        responseController.stream,
        429, // HTTP status code for "Too Many Requests"
      );
    }

    requestCounts[ip] = count + 1;

    // Schedule a function to decrement the count after the time window has elapsed
    Timer(timeWindow, () {
      requestCounts[ip] = (requestCounts[ip] ?? 1) - 1;
    });

    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
