import 'package:kitetech_student_portal/data/model/message_content.dart';
import 'package:kitetech_student_portal/data/model/message_room_member.dart';

class MessageRoom {
  final String id;
  final String name;
  final bool isGroup;
  final DateTime createdDate;
  final String createdBy;
  final List<MessageRoomMember> members;
  final List<MessageContent> messageContents;

  MessageRoom({
    required this.id,
    required this.name,
    required this.isGroup,
    required this.createdDate,
    required this.createdBy,
    required this.members,
    required this.messageContents,
  });

  factory MessageRoom.fromJson(Map<String, dynamic> json) {
    return MessageRoom(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      isGroup: json['isGroup'] ?? false,
      createdDate: DateTime.parse(
          json['createdDate'] ?? DateTime.now().toIso8601String()),
      createdBy: json['createdBy'] ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((member) => MessageRoomMember.fromJson(member))
              .toList() ??
          [],
      messageContents: (json['messageContents'] as List<dynamic>?)
              ?.map((content) => MessageContent.fromJson(content))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isGroup': isGroup,
      'createdDate': createdDate.toIso8601String(),
      'createdBy': createdBy,
      'members': members.map((member) => member.toJson()).toList(),
      'messageContents':
          messageContents.map((content) => content.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'MessageRoom(id: $id, name: $name, isGroup: $isGroup, createdDate: $createdDate, createdBy: $createdBy, members: $members, messageContents: $messageContents)';
  }
}
