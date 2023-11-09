import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<http.Response> get({required String url});
  Future<http.Response> post(
      {required String url,
      Map<String, String>? headers,
      required String jsonBody});
  Future<http.Response> put(
      {required String url,
      Map<String, String>? headers,
      required String jsonBody});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future<http.Response> get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future<http.Response> post(
      {required String url,
      Map<String, String>? headers,
      required String jsonBody}) async {
    final response =
        await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    return response;
  }

  @override
  Future<http.Response> put(
      {required String url,
      Map<String, String>? headers,
      required String jsonBody}) async {
    final response =
        await client.put(Uri.parse(url), headers: headers, body: jsonBody);
    return response;
  }
}
