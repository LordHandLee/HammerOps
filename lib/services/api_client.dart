import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({http.Client? client})
      : _client = client ?? http.Client(),
        baseUrl = const String.fromEnvironment(
          'HAMMEROPS_API_BASE',
          defaultValue: 'http://localhost:8080',
        );

  final String baseUrl;
  final http.Client _client;

  Future<Map<String, dynamic>> postJson(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    String? bearer,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: {
        'content-type': 'application/json',
        if (bearer != null) 'authorization': 'Bearer $bearer',
        ...?headers,
      },
      body: jsonEncode(body ?? {}),
    );
    _check(response);
    return _decode(response);
  }

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? query,
    String? bearer,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final response = await _client.get(
      uri,
      headers: {
        if (bearer != null) 'authorization': 'Bearer $bearer',
        ...?headers,
      },
    );
    _check(response);
    return _decode(response);
  }

  void _check(http.Response r) {
    if (r.statusCode < 200 || r.statusCode >= 300) {
      throw Exception('API ${r.statusCode}: ${r.body}');
    }
  }

  Map<String, dynamic> _decode(http.Response r) {
    if (r.body.isEmpty) return {};
    return jsonDecode(r.body) as Map<String, dynamic>;
  }
}
