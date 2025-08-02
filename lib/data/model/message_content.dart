// ignore: constant_identifier_names
enum MessageType { TEXT, IMAGE, FILE, AUDIO, VIDEO, LOCATION }

class MessageContent {
  final String id;
  final String content;
  final DateTime dateSent;
  final MessageType messageType;
  final String messageRoomId;
  final String userId;

  MessageContent({
    required this.id,
    required this.content,
    required this.dateSent,
    required this.messageType,
    required this.messageRoomId,
    required this.userId,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      dateSent:
          DateTime.parse(json['dateSent'] ?? DateTime.now().toIso8601String()),
      messageType: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == json['messageType'],
        orElse: () => MessageType.TEXT,
      ),
      messageRoomId: json['messageRoomId'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dateSent': dateSent.toIso8601String(),
      'messageType': messageType.toString().split('.').last,
      'messageRoomId': messageRoomId,
      'userId': userId,
    };
  }
}
