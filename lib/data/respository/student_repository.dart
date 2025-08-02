import 'dart:convert';
import 'dart:io';

import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/client/api_client.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudentRepository {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
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

  // Chat User Operations
  Future<Map<String, dynamic>> loginChatUser(
      {required String username,
      required String password,
      required String fullName}) async {
    try {
      print('Login chat user: $username, $password, $fullName');
      final result = await apiClient.postJson<Map<String, dynamic>>(
        APIRoute.javaBaseUrl,
        path: APIRoute.chatUserLogin,
        body: {
          'username': username,
          'password': password,
          'fullName': fullName,
        },
        convert: (json) {
          return json;
        },
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final result = await apiClient.getJson<List<Map<String, dynamic>>>(
        APIRoute.javaBaseUrl,
        path: APIRoute.chatUserAll,
        convert: (json) {
          if (json is List) {
            return json.map((item) => item as Map<String, dynamic>).toList();
          }
          return [];
        },
      );
      return result;
    } catch (e) {
      print('Error in getAllUsers: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> searchUsersByUsername(
      String username) async {
    try {
      final result = await apiClient.getJson<List<Map<String, dynamic>>>(
        APIRoute.javaBaseUrl,
        path: '${APIRoute.chatUserSearch}/$username',
        convert: (json) {
          if (json is List) {
            return json.map((item) => item as Map<String, dynamic>).toList();
          }
          return [];
        },
      );
      return result;
    } catch (e) {
      print('Error in searchUsersByUsername: $e');
      rethrow;
    }
  }

  // Message Content Operations
  Future<List<Map<String, dynamic>>> getMessagesByRoomId(String roomId) async {
    try {
      final result = await apiClient.getJson<List<Map<String, dynamic>>>(
        APIRoute.javaBaseUrl,
        path: '${APIRoute.messageContent}/$roomId',
        convert: (json) {
          if (json is List) {
            return json.map((item) => item as Map<String, dynamic>).toList();
          }
          return [];
        },
      );
      return result;
    } catch (e) {
      print('Error in getMessagesByRoomId: $e');
      rethrow;
    }
  }

  // Message Room Operations
  Future<Map<String, dynamic>> findChatRoomByMembers(
      List<String> members) async {
    try {
      final queryParams = members.map((member) => 'members=$member').join('&');
      final result = await apiClient.getJson<Map<String, dynamic>>(
        APIRoute.javaBaseUrl,
        path: '${APIRoute.messageRoomFind}?$queryParams',
        convert: (json) {
          return json;
        },
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createChatRoom(
      List<String> members, String userName) async {
    try {
      final queryParams = members.map((member) => 'members=$member').join('&');
      final result = await apiClient.postJson<Map<String, dynamic>>(
        APIRoute.javaBaseUrl,
        path: '${APIRoute.messageRoomCreate}?$queryParams&userName=$userName',
        convert: (json) {
          print('Create chat room response: $json');
          return json;
        },
      );
      return result;
    } catch (e) {
      print('Error in createChatRoom: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> findChatRoomsWithContent(
      String username, String roomId) async {
    try {
      final result = await apiClient.getJson<List<Map<String, dynamic>>>(
        APIRoute.javaBaseUrl,
        path: '${APIRoute.messageRoomFindWithContent}/$username/$roomId',
        convert: (json) {
          if (json is List) {
            return json.map((item) => item as Map<String, dynamic>).toList();
          }
          return [];
        },
      );
      return result;
    } catch (e) {
      print('Error in findChatRoomsWithContent: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> findMessageRoomById(String roomId) async {
    try {
      final result = await apiClient.getJson<Map<String, dynamic>>(
        APIRoute.javaBaseUrl,
        path: '${APIRoute.messageRoom}/$roomId',
        convert: (json) {
          print('Find message room response: $json');
          return json;
        },
      );
      return result;
    } catch (e) {
      print('Error in findMessageRoomById: $e');
      rethrow;
    }
  }

  // Message Room Member Operations
  Future<Map<String, dynamic>> updateLastSeen(
      String roomId, String memberId) async {
    try {
      final result = await apiClient.postJson<Map<String, dynamic>>(
        APIRoute.javaBaseUrl,
        path: '${APIRoute.messageRoomMemberUpdateLastSeen}/$roomId/$memberId',
        convert: (json) {
          print('Update last seen response: $json');
          return json;
        },
      );
      return result;
    } catch (e) {
      print('Error in updateLastSeen: $e');
      rethrow;
    }
  }

  void logout() async {
    await secureStorage.deleteAll();
  }
}
