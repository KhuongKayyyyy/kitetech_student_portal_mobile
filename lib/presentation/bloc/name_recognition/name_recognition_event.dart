part of 'name_recognition_bloc.dart';

@immutable
sealed class NameRecognitionEvent {}

final class NameRecognitionInitialEvent extends NameRecognitionEvent {}

final class NameRecognitionCreateEvent extends NameRecognitionEvent {
  final NameRecognition nameRecognitionModel;

  NameRecognitionCreateEvent({required this.nameRecognitionModel});
}

final class NameRecognitionGetEvent extends NameRecognitionEvent {}

final class NameRecognitionGetByStudentIdEvent extends NameRecognitionEvent {
  final String studentId;

  NameRecognitionGetByStudentIdEvent({required this.studentId});
}
