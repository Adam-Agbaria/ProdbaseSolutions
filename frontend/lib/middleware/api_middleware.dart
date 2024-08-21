import 'package:http/http.dart' as http;
import '../services/api_service.dart';

class ApiMiddleware extends ApiService {
  ApiMiddleware({required String baseUrl}) : super(baseUrl: baseUrl);

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isMethod && invocation.memberName != #noSuchMethod) {
      // Log the request
      print('Making API Request: ${invocation.memberName}');

      var result = super.noSuchMethod(invocation);

      if (result is Future<http.Response>) {
        return result.then((response) {
          // Log the response
          print('Received API Response: ${response.statusCode}');
          return response;
        });
      }
      return result;
    }
    return super.noSuchMethod(invocation);
  }
}
