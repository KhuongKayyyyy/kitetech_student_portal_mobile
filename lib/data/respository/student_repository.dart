import 'dart:convert';
import 'dart:io';

import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';

class StudentRepository {
  Future<AppUser> login(String username, String password) async {
    var client = HttpClient();
    try {
      var request = await client.postUrl(Uri.parse(APIRoute.login));
      request.headers.set('Content-Type', 'application/json');
      request.write(json.encode({'username': username, 'password': password}));
      var response = await request.close();
      if (response.statusCode == 200) {
        var body = await response.transform(utf8.decoder).join();
        var appUser = AppUser.fromJson(json.decode(body));
        return appUser;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login");
    }
  }
}
