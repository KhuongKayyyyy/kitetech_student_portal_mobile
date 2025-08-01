import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/data/client/api_client.dart';
import 'package:kitetech_student_portal/data/model/name_recognition.dart';

class NameRecognitionRepository {
  final ApiClient _client;

  NameRecognitionRepository(this._client);

  Future<List<NameRecognition>> getListNameRecognitionByStudentID(
      String studentId) async {
    try {
      final result = await _client.getJson<List<NameRecognition>>(
        APIRoute.javaBaseUrl,
        path: APIRoute.listNameRecognition,
        query: {'studentID': studentId},
        convert: (json) {
          // Extract the data field from the response
          final data = json['data'];
          if (data is List) {
            return data.map((item) {
              if (item is Map<String, dynamic>) {
                // Handle id conversion if needed
                if (item['id'] is int) {
                  item['id'] = item['id'].toString();
                }
                // Handle time conversion if needed
                if (item['time'] is String) {
                  item['time'] = DateTime.parse(item['time']);
                }
                return NameRecognition.fromJson(item);
              }
              throw Exception('Invalid item format in response');
            }).toList();
          }
          throw Exception('Invalid response format');
        },
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<NameRecognition?> createNameRecognition(
      NameRecognition nameRecognition) async {
    try {
      final result = await _client.postJson(
        APIRoute.javaBaseUrl,
        path: APIRoute.createNameRecognition,
        body: nameRecognition.toJson(),
        convert: (json) {
          final data = json['data'];
          if (data is Map<String, dynamic>) {
            if (data['id'] is int) {
              data['id'] = data['id'].toString();
            }
            if (data['time'] is String) {
              data['time'] = DateTime.parse(data['time']);
            }
            return NameRecognition.fromJson(data);
          }
          return null;
        },
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
