import 'package:kitetech_student_portal/data/model/class.dart';
import 'package:kitetech_student_portal/data/model/news.dart';
import 'package:kitetech_student_portal/data/model/student.dart';

class FakeData {
  static final Student student = Student(
    name: 'Nguyen Dat Khuong',
    email: 'khuongnd@kitetech.vn',
    studentId: '52100973',
    major: 'Computer Science',
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
}
