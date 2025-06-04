class AppUser {
  final String id;
  final String name;
  final String password;
  final String imageURL;
  final String status;

  AppUser({
    required this.id,
    required this.name,
    required this.password,
    required this.imageURL,
    required this.status,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? 'NoId',
      name: json['username'] ?? '',
      password: json['password'] ?? '',
      imageURL: json['avatarUrl'] ?? 'no-image',
      status: json['status'] ?? 'NoStatus',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': name,
      'password': password,
      'imageURL': imageURL,
      'status': status,
    };
  }
}
