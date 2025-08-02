class APIRoute {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String baseUrl = 'http://103.56.162.192:8888';
  static const String javaBaseUrl = 'http://192.168.1.17:8080';
  static const String baseUrlTest = 'http://192.168.88.132:5001';
  static const String apiVersion = 'api/v1';

  static const String login = '$baseUrl/auth/login';
  static const String userInfo = '$baseUrl/auth/current-user';

  // Chat User endpoints
  static const String chatUserLogin = '$apiVersion/chat_user';
  static const String chatUserOnline = '$chatUserLogin/online';
  static const String chatUserAll = '$chatUserLogin/all';
  static const String chatUserSearch = '$chatUserLogin/search';

  // Message Content endpoints
  static const String messageContent = '$apiVersion/messagecontents';

  // Message Room endpoints
  static const String messageRoom = '$apiVersion/messageroom';
  static const String messageRoomFind = '$messageRoom/find-chat-room';
  static const String messageRoomCreate = '$messageRoom/create-chat-room';
  static const String messageRoomFindWithContent =
      '$messageRoom/find-chat-room-at-least-one-content';
  static const String messageRoomByUserName = '$messageRoom/user';

  // Message Room Member endpoints
  static const String messageRoomMember = '$apiVersion/messageroommember';
  static const String messageRoomMemberUpdateLastSeen =
      '$messageRoomMember/update-last-seen';

  static const String nameRecognition = '$apiVersion/name_recognition';
  static const String createNameRecognition = nameRecognition;
  static const String listNameRecognition = '$nameRecognition/by-student-id';
}
