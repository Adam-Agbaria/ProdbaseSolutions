import 'package:http/http.dart' as http;

class MiddlewareClient extends http.BaseClient {
  final http.Client _inner;

  MiddlewareClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Any middleware logic before sending request
    print("Sending request to: ${request.url}");

    final response = await _inner.send(request);

    // Any middleware logic after getting the response
    print("Received response with status code: ${response.statusCode}");

    return response;
  }
}
