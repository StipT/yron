import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:yron_data/yron_data.dart';

void main() {
  final baseUrl = Uri.parse('https://api.yron.test/');

  test('get decodes JSON and resolves path and query', () async {
    late Uri requested;
    final client = ApiClient(
      baseUrl: baseUrl,
      httpClient: MockClient((request) async {
        requested = request.url;
        return http.Response(jsonEncode({'id': 1}), 200);
      }),
    );

    final result = await client.get('workouts', query: {'limit': '5'});

    expect(result, {'id': 1});
    expect(requested.toString(), 'https://api.yron.test/workouts?limit=5');
  });

  test('post sends JSON body', () async {
    final client = ApiClient(
      baseUrl: baseUrl,
      httpClient: MockClient((request) async {
        expect(request.headers['Content-Type'], startsWith('application/json'));
        expect(jsonDecode(request.body), {'name': 'Push day'});
        return http.Response('', 201);
      }),
    );

    expect(await client.post('plans', body: {'name': 'Push day'}), isNull);
  });

  test('non-2xx responses throw ApiException', () {
    final client = ApiClient(
      baseUrl: baseUrl,
      httpClient: MockClient((_) async => http.Response('not found', 404)),
    );

    expect(
      client.get('missing'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404),
      ),
    );
  });
}
