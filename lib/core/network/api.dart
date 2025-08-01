class APIRoute {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String baseUrl = 'http://103.56.162.192:8888';
  static const String javaBaseUrl = 'http://192.168.1.17:8080';
  static const String baseUrlTest = 'http://192.168.88.132:5001';
  static const String apiVersion = 'api/v1';

  static const String login = '$baseUrl/auth/login';
  static const String userInfo = '$baseUrl/auth/current-user';

  static const String nameRecognition = '$apiVersion/name_recognition';
  static const String createNameRecognition = nameRecognition;
  static const String listNameRecognition = '$nameRecognition/by-student-id';
}
