// ignore: depend_on_referenced_packages
import 'package:kitetech_student_portal/data/model/chat_request.dart';
import 'package:kitetech_student_portal/data/model/chat_user.dart';
import 'package:kitetech_student_portal/data/model/class.dart';
import 'package:kitetech_student_portal/data/model/enums/chat_request_status.dart';
import 'package:kitetech_student_portal/data/model/message_content.dart';
import 'package:kitetech_student_portal/data/model/message_room.dart';
import 'package:kitetech_student_portal/data/model/message_room_member.dart';
import 'package:kitetech_student_portal/data/model/name_recognition.dart';
import 'package:kitetech_student_portal/data/model/news.dart';
import 'package:kitetech_student_portal/data/model/score_data.dart';
import 'package:kitetech_student_portal/data/model/student.dart';
import 'package:kitetech_student_portal/data/model/student_card_data.dart';

class FakeData {
  static final Student student = Student(
    name: 'Nguyen Dat Khuong',
    email: 'khuongnd@kitetech.vn',
    studentId: '52100973',
    major: 'Computer Science',
  );

  static final StudentCardData studentCardData = StudentCardData(
    studentName: 'Nguyen Dat Khuong',
    studentId: '52100973',
    department: 'Computer Science',
    classId: '52100973',
    major: 'Computer Science',
    birthDate: '1990-01-01',
    gender: 'Male',
    imageUrl: '',
    address: '',
  );

  static final List<News> news = [
    News(
      title: 'Tin tức mới nhất',
      description: 'Tin tức mới nhất từ trường',
      image:
          'https://www.robinradar.com/hubfs/Drone%20flying%20over%20green%20hills.jpg',
      link:
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.robinradar.com%2Fblog%2Fuas-vs-uav-vs-drones&psig=AOvVaw3W7XB1bzeG8VYn-IIqdsHc&ust=1748692488650000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMjq26aRy40DFQAAAAAdAAAAABAE',
    ),
    News(
      title: 'Tin tức mới nhất',
      description: 'Tin tức mới nhất từ trường',
      image:
          'https://www.robinradar.com/hubfs/Drone%20flying%20over%20green%20hills.jpg',
      link:
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.robinradar.com%2Fblog%2Fuas-vs-uav-vs-drones&psig=AOvVaw3W7XB1bzeG8VYn-IIqdsHc&ust=1748692488650000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMjq26aRy40DFQAAAAAdAAAAABAE',
    ),
    News(
      title: 'Tin tức mới nhất',
      description: 'Tin tức mới nhất từ trường',
      image:
          'https://www.robinradar.com/hubfs/Drone%20flying%20over%20green%20hills.jpg',
      link:
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.robinradar.com%2Fblog%2Fuas-vs-uav-vs-drones&psig=AOvVaw3W7XB1bzeG8VYn-IIqdsHc&ust=1748692488650000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMjq26aRy40DFQAAAAAdAAAAABAE',
    ),
  ];

  static final List<ClassModel> classes = [
    ClassModel(
      id: '1',
      date: DateTime(2025, 5, 1),
      time: '10:00',
      subjectId: '1',
      roomId: '1',
      period: '1',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '2',
      date: DateTime(2025, 5, 2),
      time: '08:30',
      subjectId: '2',
      roomId: '2',
      period: '1',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '3',
      date: DateTime(2025, 5, 3),
      time: '14:00',
      subjectId: '3',
      roomId: '3',
      period: '2',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '4',
      date: DateTime(2025, 5, 5),
      time: '09:15',
      subjectId: '4',
      roomId: '4',
      period: '1',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '5',
      date: DateTime(2025, 5, 6),
      time: '11:30',
      subjectId: '5',
      roomId: '5',
      period: '2',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '6',
      date: DateTime(2025, 5, 7),
      time: '13:45',
      subjectId: '6',
      roomId: '6',
      period: '3',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '7',
      date: DateTime(2025, 5, 8),
      time: '15:30',
      subjectId: '7',
      roomId: '7',
      period: '3',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '8',
      date: DateTime(2025, 5, 9),
      time: '07:45',
      subjectId: '8',
      roomId: '8',
      period: '1',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '9',
      date: DateTime(2025, 5, 12),
      time: '12:15',
      subjectId: '9',
      roomId: '9',
      period: '2',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '10',
      date: DateTime(2025, 5, 13),
      time: '16:00',
      subjectId: '10',
      roomId: '10',
      period: '4',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '11',
      date: DateTime(2025, 5, 14),
      time: '10:45',
      subjectId: '11',
      roomId: '11',
      period: '2',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '12',
      date: DateTime(2025, 5, 14),
      time: '13:15',
      subjectId: '12',
      roomId: '12',
      period: '3',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '13',
      date: DateTime(2025, 5, 14),
      time: '15:30',
      subjectId: '13',
      roomId: '13',
      period: '4',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
    ClassModel(
      id: '14',
      date: DateTime(2025, 5, 14),
      time: '08:30',
      subjectId: '14',
      roomId: '14',
      period: '1',
      weekNumbers: [1, 2, 3, 4, 5],
    ),
  ];

  static final List<NameRecognition> nameRecognitions = [
    NameRecognition(
      id: '1',
      classSessionID: '1',
      studentID: '1',
      time: DateTime.now(),
    ),
    NameRecognition(
      id: '2',
      classSessionID: '2',
      studentID: '2',
      time: DateTime.now(),
    ),
    NameRecognition(
      id: '1',
      classSessionID: '1',
      studentID: '1',
      time: DateTime.now(),
    ),
    NameRecognition(
      id: '2',
      classSessionID: '2',
      studentID: '2',
      time: DateTime.now(),
    ),
    NameRecognition(
      id: '1',
      classSessionID: '1',
      studentID: '1',
      time: DateTime.now(),
    ),
    NameRecognition(
      id: '2',
      classSessionID: '2',
      studentID: '2',
      time: DateTime.now(),
    ),
    NameRecognition(
      id: '1',
      classSessionID: '1',
      studentID: '1',
      time: DateTime.now(),
    ),
    NameRecognition(
      id: '2',
      classSessionID: '2',
      studentID: '2',
      time: DateTime.now(),
    ),
  ];

  static final List<ScoreData> scores = [
    ScoreData(
      stt: 1,
      courseName: "Lập trình mobile",
      courseCode: "CS301",
      credits: 3,
      group: "01",
      totalScore: "8.5",
      totalScoreDate: "15/12/2024",
      progressTest1: "8.0",
      progressTest1Date: "01/11/2024",
      progressTest2: "9.0",
      progressTest2Date: "15/11/2024",
      midtermScore: "8.5",
      midtermScoreDate: "30/11/2024",
      finalScore: "8.5",
      finalScoreDate: "15/12/2024",
      retestScore: "-",
      retestScoreDate: "-",
      note: "",
      semester: "Học kỳ 1",
    ),
    ScoreData(
      stt: 2,
      courseName: "Cơ sở dữ liệu",
      courseCode: "CS201",
      credits: 3,
      group: "02",
      totalScore: "7.8",
      totalScoreDate: "20/12/2024",
      progressTest1: "7.5",
      progressTest1Date: "05/11/2024",
      progressTest2: "8.0",
      progressTest2Date: "20/11/2024",
      midtermScore: "7.5",
      midtermScoreDate: "02/12/2024",
      finalScore: "8.0",
      finalScoreDate: "20/12/2024",
      retestScore: "-",
      retestScoreDate: "-",
      note: "",
      semester: "Học kỳ 1",
    ),
    ScoreData(
      stt: 3,
      courseName: "Mạng máy tính",
      courseCode: "CS302",
      credits: 3,
      group: "01",
      totalScore: "6.5",
      totalScoreDate: "18/12/2024",
      progressTest1: "6.0",
      progressTest1Date: "03/11/2024",
      progressTest2: "7.0",
      progressTest2Date: "18/11/2024",
      midtermScore: "6.5",
      midtermScoreDate: "28/11/2024",
      finalScore: "6.5",
      finalScoreDate: "18/12/2024",
      retestScore: "7.5",
      retestScoreDate: "10/01/2025",
      note: "Thi lại",
      semester: "Học kỳ 1",
    ),
    ScoreData(
      stt: 4,
      courseName: "Phân tích thiết kế hệ thống",
      courseCode: "CS401",
      credits: 4,
      group: "03",
      totalScore: "9.2",
      totalScoreDate: "22/12/2024",
      progressTest1: "9.0",
      progressTest1Date: "07/11/2024",
      progressTest2: "9.5",
      progressTest2Date: "22/11/2024",
      midtermScore: "9.0",
      midtermScoreDate: "05/12/2024",
      finalScore: "9.2",
      finalScoreDate: "22/12/2024",
      retestScore: "-",
      retestScoreDate: "-",
      note: "",
      semester: "Học kỳ 1",
    ),
    ScoreData(
      stt: 5,
      courseName: "Tiếng Anh chuyên ngành",
      courseCode: "EN101",
      credits: 2,
      group: "04",
      totalScore: "8.0",
      totalScoreDate: "16/12/2024",
      progressTest1: "8.5",
      progressTest1Date: "02/11/2024",
      progressTest2: "7.5",
      progressTest2Date: "16/11/2024",
      midtermScore: "8.0",
      midtermScoreDate: "01/12/2024",
      finalScore: "8.0",
      finalScoreDate: "16/12/2024",
      retestScore: "-",
      retestScoreDate: "-",
      note: "",
      semester: "Học kỳ 1",
    ),
    ScoreData(
      stt: 1,
      courseName: "Trí tuệ nhân tạo",
      courseCode: "CS501",
      credits: 4,
      group: "01",
      totalScore: "8.8",
      totalScoreDate: "25/05/2025",
      progressTest1: "8.5",
      progressTest1Date: "10/04/2025",
      progressTest2: "9.0",
      progressTest2Date: "25/04/2025",
      midtermScore: "8.5",
      midtermScoreDate: "10/05/2025",
      finalScore: "9.0",
      finalScoreDate: "25/05/2025",
      retestScore: "-",
      retestScoreDate: "-",
      note: "",
      semester: "Học kỳ 2",
    ),
    ScoreData(
      stt: 2,
      courseName: "Phát triển ứng dụng web",
      courseCode: "CS303",
      credits: 3,
      group: "02",
      totalScore: "7.5",
      totalScoreDate: "20/05/2025",
      progressTest1: "7.0",
      progressTest1Date: "05/04/2025",
      progressTest2: "8.0",
      progressTest2Date: "20/04/2025",
      midtermScore: "7.5",
      midtermScoreDate: "05/05/2025",
      finalScore: "7.5",
      finalScoreDate: "20/05/2025",
      retestScore: "-",
      retestScoreDate: "-",
      note: "",
      semester: "Học kỳ 2",
    ),
    ScoreData(
      stt: 3,
      courseName: "Bảo mật thông tin",
      courseCode: "CS402",
      credits: 3,
      group: "01",
      totalScore: "9.0",
      totalScoreDate: "28/05/2025",
      progressTest1: "8.5",
      progressTest1Date: "12/04/2025",
      progressTest2: "9.5",
      progressTest2Date: "28/04/2025",
      midtermScore: "9.0",
      midtermScoreDate: "12/05/2025",
      finalScore: "9.0",
      finalScoreDate: "28/05/2025",
      retestScore: "-",
      retestScoreDate: "-",
      note: "",
      semester: "Học kỳ 2",
    ),
    ScoreData(
      stt: 4,
      courseName: "Kỹ thuật phần mềm",
      courseCode: "CS202",
      credits: 4,
      group: "03",
      totalScore: "6.0",
      totalScoreDate: "22/05/2025",
      progressTest1: "5.5",
      progressTest1Date: "08/04/2025",
      progressTest2: "6.5",
      progressTest2Date: "22/04/2025",
      midtermScore: "6.0",
      midtermScoreDate: "08/05/2025",
      finalScore: "6.0",
      finalScoreDate: "22/05/2025",
      retestScore: "7.0",
      retestScoreDate: "15/06/2025",
      note: "Thi lại",
      semester: "Học kỳ 2",
    ),
    // Add more sample data as needed
  ];

  static final List<ChatUser> chatUsers = [
    ChatUser(
      username: 'Nguyen Dat Khuong',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.ONLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Huynh Trieu Vy',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.OFFLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Bui Ngoc Truong',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.OFFLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Tran Minh An',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.ONLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Le Thi Hoa',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.OFFLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Pham Van Nam',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.ONLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Vo Thanh Linh',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.OFFLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Do Quang Huy',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.ONLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Nguyen Thi Mai',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.OFFLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
    ChatUser(
      username: 'Hoang Van Duc',
      avatarUrl:
          'https://images.immediate.co.uk/production/volatile/sites/3/2024/01/avatar-the-last-airbender-cdc2b79.jpg?resize=1200%2C630',
      status: UserStatus.ONLINE,
      password: '',
      lastLogin: DateTime.now(),
    ),
  ];

  static final List<ChatRequest> sentRequest = [
    ChatRequest(
        id: "1",
        sentUSerId: "1",
        receiveUserId: "2",
        requestStatus: ChatRequestStatus.PENDING),
    ChatRequest(
        id: "2",
        sentUSerId: "1",
        receiveUserId: "3",
        requestStatus: ChatRequestStatus.PENDING),
    ChatRequest(
        id: "3",
        sentUSerId: "1",
        receiveUserId: "4",
        requestStatus: ChatRequestStatus.PENDING)
  ];

  static final List<ChatRequest> receivedRequest = [
    ChatRequest(
        id: "1",
        sentUSerId: "2",
        receiveUserId: "1",
        requestStatus: ChatRequestStatus.PENDING),
    ChatRequest(
        id: "2",
        sentUSerId: "3",
        receiveUserId: "1",
        requestStatus: ChatRequestStatus.PENDING),
    ChatRequest(
        id: "3",
        sentUSerId: "4",
        receiveUserId: "1",
        requestStatus: ChatRequestStatus.PENDING),
  ];

  static final List<ChatRequest> approvedRequest = [
    ChatRequest(
        id: "1",
        sentUSerId: "1",
        receiveUserId: "2",
        requestStatus: ChatRequestStatus.APPROVED),
    ChatRequest(
        id: "1",
        sentUSerId: "1",
        receiveUserId: "2",
        requestStatus: ChatRequestStatus.APPROVED),
    ChatRequest(
        id: "1",
        sentUSerId: "1",
        receiveUserId: "2",
        requestStatus: ChatRequestStatus.APPROVED),
  ];

  static final List<MessageRoom> messageRooms = [
    MessageRoom(
      id: "1",
      name: "Group Chat 1",
      isGroup: true,
      createdDate: DateTime.now().subtract(const Duration(days: 2)),
      createdBy: "1",
      members: [
        MessageRoomMember(
          userId: "1",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 5)),
          messageRoomId: '',
          isAdmin: true,
        ),
        MessageRoomMember(
          userId: "2",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 10)),
          messageRoomId: '',
          isAdmin: true,
        ),
        MessageRoomMember(
          userId: "3",
          lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
          messageRoomId: '',
          isAdmin: true,
        ),
      ],
      messageContents: [
        MessageContent(
          id: "1",
          content: "Hello everyone!",
          dateSent: DateTime.now().subtract(const Duration(minutes: 30)),
          messageType: MessageType.TEXT,
          messageRoomId: '',
          userId: '',
        ),
        MessageContent(
          id: "2",
          content: "How's everyone doing?",
          dateSent: DateTime.now().subtract(const Duration(minutes: 15)),
          messageType: MessageType.TEXT,
          messageRoomId: '',
          userId: '',
        ),
      ],
    ),
    MessageRoom(
      id: "2",
      name: "",
      isGroup: false,
      createdDate: DateTime.now().subtract(const Duration(days: 1)),
      createdBy: "1",
      members: [
        MessageRoomMember(
          userId: "1",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 2)),
          messageRoomId: '',
          isAdmin: true,
        ),
        MessageRoomMember(
          userId: "2",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 1)),
          messageRoomId: '',
          isAdmin: true,
        ),
      ],
      messageContents: [
        MessageContent(
          id: "3",
          content: "Hey, how are you?",
          dateSent: DateTime.now().subtract(const Duration(minutes: 20)),
          messageType: MessageType.TEXT,
          messageRoomId: '',
          userId: '',
        ),
        MessageContent(
          id: "4",
          content: "I'm good, thanks!",
          dateSent: DateTime.now().subtract(const Duration(minutes: 10)),
          messageType: MessageType.TEXT,
          messageRoomId: '',
          userId: '',
        ),
      ],
    ),
    MessageRoom(
      id: "3",
      name: "Study Group",
      isGroup: true,
      createdDate: DateTime.now().subtract(const Duration(days: 5)),
      createdBy: "3",
      members: [
        MessageRoomMember(
          userId: "1",
          lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
          messageRoomId: '',
          isAdmin: true,
        ),
        MessageRoomMember(
          userId: "3",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 30)),
          messageRoomId: '',
          isAdmin: true,
        ),
        MessageRoomMember(
          userId: "4",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 45)),
          messageRoomId: '',
          isAdmin: true,
        ),
      ],
      messageContents: [
        MessageContent(
          id: "5",
          content: "Don't forget about the exam tomorrow",
          dateSent: DateTime.now().subtract(const Duration(hours: 1)),
          messageType: MessageType.TEXT,
          messageRoomId: '',
          userId: '',
        ),
      ],
    ),
    MessageRoom(
      id: "4",
      name: "",
      isGroup: false,
      createdDate: DateTime.now().subtract(const Duration(hours: 6)),
      createdBy: "4",
      members: [
        MessageRoomMember(
          userId: "1",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 3)),
          messageRoomId: '',
          isAdmin: true,
        ),
        MessageRoomMember(
          userId: "4",
          lastSeen: DateTime.now().subtract(const Duration(minutes: 5)),
          messageRoomId: '',
          isAdmin: true,
        ),
      ],
      messageContents: [
        MessageContent(
          id: "6",
          content: "Can you help me with the homework?",
          dateSent: DateTime.now().subtract(const Duration(minutes: 25)),
          messageType: MessageType.TEXT,
          messageRoomId: '',
          userId: '',
        ),
        MessageContent(
          id: "7",
          content: "Sure, what do you need help with?",
          dateSent: DateTime.now().subtract(const Duration(minutes: 20)),
          messageType: MessageType.TEXT,
          messageRoomId: '',
          userId: '',
        ),
      ],
    ),
  ];
}
