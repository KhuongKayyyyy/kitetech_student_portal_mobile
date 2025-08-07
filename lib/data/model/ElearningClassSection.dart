import 'package:kitetech_student_portal/data/model/ElearningClass.dart';

class ClassSectionModel {
  final int id;
  final ElearningClassModel elearningClass;
  final int section;
  final String name;

  ClassSectionModel({
    required this.id,
    required this.elearningClass,
    required this.section,
    required this.name,
  });
}

class MockClassSectionData {
  static List<ClassSectionModel> classSections = [
    ClassSectionModel(
      id: 1,
      elearningClass: MockData.courses[0],
      section: 1,
      name: "Introduction to Programming Concepts",
    ),
    ClassSectionModel(
      id: 2,
      elearningClass: MockData.courses[1],
      section: 2,
      name: "Data Structures and Algorithms",
    ),
    ClassSectionModel(
      id: 3,
      elearningClass: MockData.courses[2],
      section: 1,
      name: "Database Design Fundamentals",
    ),
    ClassSectionModel(
      id: 4,
      elearningClass: MockData.courses[3],
      section: 3,
      name: "Software Engineering Principles",
    ),
    ClassSectionModel(
      id: 5,
      elearningClass: MockData.courses[0],
      section: 2,
      name: "Advanced Programming Techniques",
    ),
  ];
}
