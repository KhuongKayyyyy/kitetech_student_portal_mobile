import 'package:kitetech_student_portal/data/model/ElearningClassSection.dart';

enum ClassSectionMaterialType {
  docs,
  announcement,
  link,
  submission,
}

class ClassSectionMaterialModel {
  final int id;
  final ClassSectionModel classSection;
  final String material;
  final ClassSectionMaterialType type;
  final String content;

  ClassSectionMaterialModel({
    required this.id,
    required this.classSection,
    required this.material,
    required this.type,
    required this.content,
  });
}

class MockClassSectionMaterialData {
  static List<ClassSectionMaterialModel> materials = [
    ClassSectionMaterialModel(
      id: 1,
      classSection: MockClassSectionData.classSections[0],
      material: "Introduction to Programming - Week 1 Slides",
      type: ClassSectionMaterialType.docs,
      content:
          "Basic programming concepts, variables, and data types. Includes examples and exercises for beginners.",
    ),
    ClassSectionMaterialModel(
      id: 2,
      classSection: MockClassSectionData.classSections[0],
      material: "Assignment 1: Hello World Program",
      type: ClassSectionMaterialType.submission,
      content:
          "Create your first program that prints 'Hello World' to the console. Due date: Next Friday.",
    ),
    ClassSectionMaterialModel(
      id: 3,
      classSection: MockClassSectionData.classSections[1],
      material: "Important: Midterm Exam Schedule",
      type: ClassSectionMaterialType.announcement,
      content:
          "The midterm exam will be held on March 15th at 2:00 PM in Room A101. Please bring your student ID.",
    ),
    ClassSectionMaterialModel(
      id: 4,
      classSection: MockClassSectionData.classSections[1],
      material: "Data Structures Reference Guide",
      type: ClassSectionMaterialType.docs,
      content:
          "Comprehensive guide covering arrays, linked lists, stacks, queues, and trees with implementation examples.",
    ),
    ClassSectionMaterialModel(
      id: 5,
      classSection: MockClassSectionData.classSections[2],
      material: "Useful Database Tools",
      type: ClassSectionMaterialType.link,
      content:
          "https://www.postgresql.org/docs/ - PostgreSQL documentation and tutorials for database management.",
    ),
    ClassSectionMaterialModel(
      id: 6,
      classSection: MockClassSectionData.classSections[2],
      material: "Database Project Proposal",
      type: ClassSectionMaterialType.submission,
      content:
          "Submit a 2-page proposal for your final database project. Include entity-relationship diagrams.",
    ),
    ClassSectionMaterialModel(
      id: 7,
      classSection: MockClassSectionData.classSections[3],
      material: "Class Cancelled - March 10th",
      type: ClassSectionMaterialType.announcement,
      content:
          "Due to the conference, the class scheduled for March 10th is cancelled. We will resume next week.",
    ),
    ClassSectionMaterialModel(
      id: 8,
      classSection: MockClassSectionData.classSections[3],
      material: "Software Development Life Cycle",
      type: ClassSectionMaterialType.docs,
      content:
          "Detailed overview of SDLC phases: planning, analysis, design, implementation, testing, and maintenance.",
    ),
    ClassSectionMaterialModel(
      id: 9,
      classSection: MockClassSectionData.classSections[4],
      material: "Advanced Algorithms Tutorial",
      type: ClassSectionMaterialType.link,
      content:
          "https://www.geeksforgeeks.org/advanced-algorithms/ - Comprehensive tutorials on advanced programming algorithms.",
    ),
    ClassSectionMaterialModel(
      id: 10,
      classSection: MockClassSectionData.classSections[4],
      material: "Code Review Assignment",
      type: ClassSectionMaterialType.submission,
      content:
          "Review and analyze the provided code samples. Submit your findings and improvement suggestions.",
    ),
    ClassSectionMaterialModel(
      id: 11,
      classSection: MockClassSectionData.classSections[0],
      material: "Programming Best Practices Guide",
      type: ClassSectionMaterialType.docs,
      content:
          "Guidelines for writing clean, maintainable code including naming conventions, commenting, and structure.",
    ),
    ClassSectionMaterialModel(
      id: 12,
      classSection: MockClassSectionData.classSections[1],
      material: "Online Coding Platform",
      type: ClassSectionMaterialType.link,
      content:
          "https://leetcode.com/ - Practice coding problems and improve your algorithmic thinking skills.",
    ),
    ClassSectionMaterialModel(
      id: 13,
      classSection: MockClassSectionData.classSections[2],
      material: "New Office Hours Schedule",
      type: ClassSectionMaterialType.announcement,
      content:
          "Office hours are now Tuesdays and Thursdays from 3:00-5:00 PM in Room B201. No appointment needed.",
    ),
    ClassSectionMaterialModel(
      id: 14,
      classSection: MockClassSectionData.classSections[3],
      material: "Team Project Guidelines",
      type: ClassSectionMaterialType.docs,
      content:
          "Instructions for the final team project including team formation, deliverables, and evaluation criteria.",
    ),
    ClassSectionMaterialModel(
      id: 15,
      classSection: MockClassSectionData.classSections[4],
      material: "Final Project Submission",
      type: ClassSectionMaterialType.submission,
      content:
          "Submit your completed final project including source code, documentation, and presentation slides.",
    ),
  ];
}
