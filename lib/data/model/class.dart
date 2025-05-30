class ClassModel {
  final String id;
  final DateTime date;
  final String time;
  final String subjectId;
  final String roomId;
  final String period;
  final List<int> weekNumbers;

  ClassModel({
    required this.id,
    required this.date,
    required this.time,
    required this.subjectId,
    required this.roomId,
    required this.period,
    required this.weekNumbers,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      subjectId: json['subjectId'] as String,
      roomId: json['roomId'] as String,
      period: json['period'] as String,
      weekNumbers: List<int>.from(json['weekNumbers'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'time': time,
      'subjectId': subjectId,
      'roomId': roomId,
      'period': period,
      'weekNumbers': weekNumbers,
    };
  }
}
