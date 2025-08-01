class NameRecognition {
  final String id;
  final String classSessionID;
  final String studentID;
  final DateTime time;
  final String? name;

  NameRecognition(
      {required this.id,
      required this.classSessionID,
      required this.studentID,
      required this.time,
      this.name});

  factory NameRecognition.fromJson(Map<String, dynamic> json) {
    return NameRecognition(
      id: json['id'],
      classSessionID: json['classSessionID'],
      studentID: json['studentID'],
      time: json['time'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'classSessionID': classSessionID,
      'studentID': studentID,
    };
  }
}
