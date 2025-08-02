import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/client/api_client.dart';
import 'package:kitetech_student_portal/data/model/chat_user.dart';

class ChatUserRepository {
  final ApiClient apiClient;

  ChatUserRepository(this.apiClient);

  Future<List<ChatUser>> getOnlineUsers() async {
    try {
      final result = await apiClient.getJson<List<ChatUser>>(
        APIRoute.javaBaseUrl,
        path: APIRoute.chatUserOnline,
        convert: (json) {
          if (json is List) {
            return json
                .map((item) => ChatUser.fromJson(item as Map<String, dynamic>))
                .toList();
          }
          return [];
        },
      );
      return result;
    } catch (e) {
      print('Error in getOnlineUsers: $e');
      rethrow;
    }
  }

  Future<List<ChatUser>> getAllUsers() async {
    try {
      final result = await apiClient.getJson<List<ChatUser>>(
        APIRoute.javaBaseUrl,
        path: APIRoute.chatUserAll,
        convert: (json) {
          if (json is List) {
            return json
                .map((item) => ChatUser.fromJson(item as Map<String, dynamic>))
                .toList();
          }
          return [];
        },
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
