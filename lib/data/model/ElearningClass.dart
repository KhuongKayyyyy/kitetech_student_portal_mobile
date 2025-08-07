class ElearningClassModel {
  final int id;
  final String code;
  final String name;
  final String instructor;
  final int credits;
  final int section;
  final String schedule;
  final String location;
  final int enrolled;
  final String description;
  final String type;
  final String semester;

  ElearningClassModel({
    required this.id,
    required this.code,
    required this.name,
    required this.instructor,
    required this.credits,
    required this.section,
    required this.schedule,
    required this.location,
    required this.enrolled,
    required this.description,
    required this.type,
    required this.semester,
  });
}

class MockData {
  static List<ElearningClassModel> courses = [
    ElearningClassModel(
      id: 1,
      code: "CS101",
      name: "Introduction to Computer Science",
      instructor: "Dr. Sarah Johnson",
      credits: 3,
      section: 1,
      schedule: "Mon, Wed, Fri 9:00-10:00 AM",
      location: "Room A101",
      enrolled: 45,
      description:
          "Fundamental concepts of computer science including programming basics, algorithms, and data structures.",
      type: "Core",
      semester: "semester_1_2024",
    ),
    ElearningClassModel(
      id: 2,
      code: "MATH201",
      name: "Calculus II",
      instructor: "Prof. Michael Chen",
      credits: 4,
      section: 2,
      schedule: "Tue, Thu 10:30-12:00 PM",
      location: "Room B205",
      enrolled: 38,
      description:
          "Advanced calculus topics including integration techniques, series, and differential equations.",
      type: "Core",
      semester: "semester_1_2024",
    ),
    ElearningClassModel(
      id: 3,
      code: "ENG102",
      name: "Academic Writing",
      instructor: "Ms. Emily Davis",
      credits: 2,
      section: 3,
      schedule: "Wed 2:00-4:00 PM",
      location: "Room C301",
      enrolled: 25,
      description:
          "Development of academic writing skills including research methods and citation formats.",
      type: "General Education",
      semester: "semester_1_2024",
    ),
    ElearningClassModel(
      id: 4,
      code: "PHYS151",
      name: "Physics I",
      instructor: "Dr. Robert Wilson",
      credits: 4,
      section: 1,
      schedule: "Mon, Wed 1:00-2:30 PM",
      location: "Lab Building L102",
      enrolled: 32,
      description:
          "Classical mechanics, thermodynamics, and wave phenomena with laboratory component.",
      type: "Core",
      semester: "semester_1_2024",
    ),
    ElearningClassModel(
      id: 5,
      code: "BIO110",
      name: "General Biology",
      instructor: "Dr. Lisa Anderson",
      credits: 3,
      section: 2,
      schedule: "Tue, Thu 8:00-9:30 AM",
      location: "Science Building S201",
      enrolled: 42,
      description:
          "Introduction to biological principles including cell structure, genetics, and evolution.",
      type: "Elective",
      semester: "semester_2_2024",
    ),
    ElearningClassModel(
      id: 6,
      code: "HIST200",
      name: "World History",
      instructor: "Prof. David Martinez",
      credits: 3,
      section: 1,
      schedule: "Mon, Wed, Fri 11:00-12:00 PM",
      location: "Room D402",
      enrolled: 28,
      description:
          "Survey of world civilizations from ancient times to the modern era.",
      type: "General Education",
      semester: "semester_2_2024",
    ),
    ElearningClassModel(
      id: 7,
      code: "CS205",
      name: "Data Structures and Algorithms",
      instructor: "Dr. Amanda Thompson",
      credits: 4,
      section: 1,
      schedule: "Tue, Thu 2:00-3:30 PM",
      location: "Computer Lab CL105",
      enrolled: 35,
      description:
          "Advanced programming concepts including data structures, algorithms, and complexity analysis.",
      type: "Core",
      semester: "semester_2_2024",
    ),
    ElearningClassModel(
      id: 8,
      code: "ART150",
      name: "Digital Design Fundamentals",
      instructor: "Ms. Rachel Green",
      credits: 3,
      section: 2,
      schedule: "Wed, Fri 3:00-4:30 PM",
      location: "Art Studio AS201",
      enrolled: 20,
      description:
          "Introduction to digital design tools and principles for multimedia applications.",
      type: "Elective",
      semester: "semester_1_2024",
    ),
    ElearningClassModel(
      id: 9,
      code: "CHEM101",
      name: "General Chemistry",
      instructor: "Dr. Kevin Brown",
      credits: 4,
      section: 1,
      schedule: "Mon, Wed, Fri 10:00-11:00 AM + Lab Thu 2:00-5:00 PM",
      location: "Chemistry Lab CH103",
      enrolled: 40,
      description:
          "Fundamental principles of chemistry including atomic structure, bonding, and chemical reactions.",
      type: "Core",
      semester: "semester_2_2024",
    ),
    ElearningClassModel(
      id: 10,
      code: "PSY101",
      name: "Introduction to Psychology",
      instructor: "Dr. Jennifer White",
      credits: 3,
      section: 3,
      schedule: "Tue, Thu 12:30-2:00 PM",
      location: "Room E305",
      enrolled: 50,
      description:
          "Overview of psychological principles including cognition, behavior, and mental processes.",
      type: "General Education",
      semester: "semester_1_2024",
    ),
  ];
}
