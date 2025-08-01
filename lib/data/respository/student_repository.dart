import 'dart:convert';
import 'dart:io';

import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/client/api_client.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudentRepository {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final ApiClient apiClient;

  StudentRepository(this.apiClient);

  Future<AppUser> getUserInfo() async {
    var accessToken = await secureStorage.read(key: APIRoute.accessToken);
    var client = HttpClient();
    try {
      var request = await client.getUrl(Uri.parse(APIRoute.userInfo));
      request.headers.set('Authorization', 'Bearer $accessToken');
      var response = await request.close();
      if (response.statusCode == 200) {
        var body = await response.transform(utf8.decoder).join();
        var responseData = json.decode(body);
        return AppUser.fromJson(responseData);
      } else {
        throw Exception("Failed to get user info");
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  Future<void> login(String username, String password) async {
    var client = HttpClient();
    try {
      var request = await client.postUrl(Uri.parse(APIRoute.login));
      request.headers.set('Content-Type', 'application/json');
      request.write(json.encode({'username': username, 'password': password}));
      var response = await request.close();
      if (response.statusCode == 200) {
        var body = await response.transform(utf8.decoder).join();
        var responseData = json.decode(body);
        if (responseData['accessToken'] != null) {
          await secureStorage.write(
              key: APIRoute.accessToken, value: responseData['accessToken']);
        }
        if (responseData['refreshToken'] != null) {
          await secureStorage.write(
              key: APIRoute.refreshToken, value: responseData['refreshToken']);
        }
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login");
    }
  }

  void logout() async {
    await secureStorage.deleteAll();
  }
}
