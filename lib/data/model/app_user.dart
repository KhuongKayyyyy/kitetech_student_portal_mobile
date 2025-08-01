class AppUser {
  final int id;
  final String username;
  final String password;
  final String fullName;
  final String email;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppUser({
    required this.id,
    required this.username,
    required this.password,
    required this.fullName,
    required this.email,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'full_name': fullName,
      'email': email,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'AppUser(id: $id, username: $username, password: $password, fullName: $fullName, email: $email, isActive: $isActive, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
