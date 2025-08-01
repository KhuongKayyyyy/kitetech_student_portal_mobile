part of 'name_recognition_bloc.dart';

@immutable
sealed class NameRecognitionState {}

final class NameRecognitionInitial extends NameRecognitionState {}

final class NameRecognitionLoading extends NameRecognitionState {}

final class NameRecognitionLoaded extends NameRecognitionState {
  final List<NameRecognition> nameRecognition;

  NameRecognitionLoaded({required this.nameRecognition});
}

final class NameRecognitionError extends NameRecognitionState {
  final String message;

  NameRecognitionError({required this.message});
}

final class NameRecognitionCreating extends NameRecognitionState {}

final class NameRecognitionCreated extends NameRecognitionState {
  final NameRecognition nameRecognition;

  NameRecognitionCreated({required this.nameRecognition});
}

final class NameRecognitionCreatingError extends NameRecognitionState {
  final String message;

  NameRecognitionCreatingError({required this.message});
}
