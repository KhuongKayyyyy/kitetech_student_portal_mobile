enum UserStatus { ONLINE, OFFLINE, AWAY, BUSY }

class ChatUser {
  final String username;
  final String password;
  final UserStatus status;
  final DateTime lastLogin;
  final String? avatarUrl;

  ChatUser({
    required this.username,
    required this.password,
    required this.status,
    required this.lastLogin,
    this.avatarUrl,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      status: UserStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => UserStatus.OFFLINE,
      ),
      lastLogin:
          DateTime.parse(json['lastLogin'] ?? DateTime.now().toIso8601String()),
      avatarUrl: json['avatarUrl'] ??
          "https://img.freepik.com/premium-vector/pensive-male-student-character-sitting-floor-with-laptop-paper-sheet-thinking-task-studying-prepare-exams_1016-15087.jpg?w=360",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'status': status.toString().split('.').last,
      'lastLogin': lastLogin.toIso8601String(),
      'avatarUrl': avatarUrl,
    };
  }
}
