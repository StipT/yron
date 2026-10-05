import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

/// Thin JSON wrapper over [http.Client]. Services build on top of this;
/// UI code should never use it directly.
class ApiClient {
  ApiClient({required Uri baseUrl, http.Client? httpClient})
    : _baseUrl = baseUrl,
      _http = httpClient ?? http.Client();

  final Uri _baseUrl;
  final http.Client _http;

  static const _jsonHeaders = {'Content-Type': 'application/json'};

  Future<Object?> get(String path, {Map<String, String>? query}) async =>
      _decode(await _http.get(_resolve(path, query)));

  Future<Object?> post(String path, {Object? body}) async => _decode(
    await _http.post(
      _resolve(path),
      headers: _jsonHeaders,
      body: jsonEncode(body),
    ),
  );

  Future<Object?> put(String path, {Object? body}) async => _decode(
    await _http.put(
      _resolve(path),
      headers: _jsonHeaders,
      body: jsonEncode(body),
    ),
  );

  Future<void> delete(String path) async =>
      _decode(await _http.delete(_resolve(path)));

  void close() => _http.close();

  Uri _resolve(String path, [Map<String, String>? query]) =>
      _baseUrl.resolve(path).replace(queryParameters: query);

  Object? _decode(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
}
