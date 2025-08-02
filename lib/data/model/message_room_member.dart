class MessageRoomMember {
  final String messageRoomId;
  final String userId;
  final bool isAdmin;
  final DateTime? lastSeen;

  MessageRoomMember({
    required this.messageRoomId,
    required this.userId,
    required this.isAdmin,
    this.lastSeen,
  });

  factory MessageRoomMember.fromJson(Map<String, dynamic> json) {
    return MessageRoomMember(
      messageRoomId: json['messageRoomId'] ?? '',
      userId: json['userId'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      lastSeen:
          json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageRoomId': messageRoomId,
      'userId': userId,
      'isAdmin': isAdmin,
      'lastSeen': lastSeen?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'MessageRoomMember(messageRoomId: $messageRoomId, userId: $userId, isAdmin: $isAdmin, lastSeen: $lastSeen)';
  }
}
