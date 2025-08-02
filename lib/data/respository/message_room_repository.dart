import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/client/api_client.dart';
import 'package:kitetech_student_portal/data/model/message_room.dart';

class MessageRoomRepository {
  final ApiClient _apiClient;

  MessageRoomRepository(this._apiClient);

  Future<List<MessageRoom>> getMessageRoomsByUserName(String userName) async {
    final response = await _apiClient.getJson(
      APIRoute.javaBaseUrl,
      path: '${APIRoute.messageRoomByUserName}/$userName',
      convert: (json) =>
          (json as List).map((item) => MessageRoom.fromJson(item)).toList(),
    );
    return response;
  }
}
