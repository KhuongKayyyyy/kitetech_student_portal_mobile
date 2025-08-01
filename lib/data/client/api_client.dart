import 'dart:convert';
import 'dart:io';

import 'package:kitetech_student_portal/core/exception/api_exception.dart';

class ApiClient {
  ApiClient({
    HttpClient? httpClient,
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    this.defaultTimeout = const Duration(seconds: 10),
  }) : _client = httpClient ?? HttpClient();

  final Map<String, String> defaultHeaders;
  final Duration defaultTimeout;
  final HttpClient _client;

  Uri _buildUri(String baseUrl, String path, [Map<String, dynamic>? query]) {
    final uri = Uri.parse('$baseUrl/$path');
    if (query != null && query.isNotEmpty) {
      return uri.replace(
          queryParameters: query.map((k, v) => MapEntry(k, v?.toString())));
    }
    return uri;
  }

  Future<R> getJson<R>(
    String baseUrl, {
    required String path,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    R Function(dynamic json)? convert,
  }) async {
    final uri = _buildUri(baseUrl, path, query);
    final mergedHeaders = {...defaultHeaders, if (headers != null) ...headers};
    try {
      final request = await _client.getUrl(uri);
      mergedHeaders.forEach((key, value) {
        request.headers.set(key, value);
      });
      final res = await request.close().timeout(defaultTimeout);
      final responseBody = await res.transform(utf8.decoder).join();
      print('responseBody: $responseBody');
      if (res.statusCode != HttpStatus.ok) {
        throw ApiException('HTTP ${res.statusCode}',
            statusCode: res.statusCode, body: responseBody);
      }
      if (convert == null) {
        return (null as R);
      }
      final decoded = jsonDecode(responseBody);
      return convert(decoded);
    } on SocketException catch (e) {
      throw ApiException('Network error: ${e.message}', cause: e);
    } on FormatException catch (e) {
      throw ApiException('Invalid JSON payload', cause: e);
    } on HttpException catch (e) {
      throw ApiException('HTTP error: ${e.message}', cause: e);
    }
  }

  Future<R> postJson<R>(
    String baseUrl, {
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    R Function(dynamic json)? convert,
  }) async {
    final uri = _buildUri(baseUrl, path);
    final mergedHeaders = {...defaultHeaders, if (headers != null) ...headers};
    try {
      final request = await _client.postUrl(uri);

      // Set headers
      mergedHeaders.forEach((key, value) {
        request.headers.set(key, value);
      });

      // Write body if provided
      if (body != null) {
        request.write(jsonEncode(body));
      }

      final res = await request.close().timeout(defaultTimeout);

      print('res.statusCode: ${res.statusCode}');
      // Read response body
      final responseBody = await res.transform(utf8.decoder).join();

      print('responseBody: $responseBody');

      if (res.statusCode != HttpStatus.ok) {
        throw ApiException('HTTP ${res.statusCode}',
            statusCode: res.statusCode, body: responseBody);
      }

      if (convert == null) {
        // For endpoints that return no JSON
        return (null as R);
      }

      final decoded = jsonDecode(responseBody);
      return convert(decoded);
    } on SocketException catch (e) {
      throw ApiException('Network error: ${e.message}', cause: e);
    } on FormatException catch (e) {
      throw ApiException('Invalid JSON payload', cause: e);
    } on HttpException catch (e) {
      throw ApiException('HTTP error: ${e.message}', cause: e);
    }
  }

  void close() => _client.close();
}
