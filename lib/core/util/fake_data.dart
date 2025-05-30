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
}
