import 'package:bloc/bloc.dart';
import 'package:kitetech_student_portal/data/client/api_client.dart';
import 'package:kitetech_student_portal/data/model/name_recognition.dart';
import 'package:kitetech_student_portal/data/respository/name_recognition_repository.dart';
import 'package:meta/meta.dart';

part 'name_recognition_event.dart';
part 'name_recognition_state.dart';

class NameRecognitionBloc
    extends Bloc<NameRecognitionEvent, NameRecognitionState> {
  final NameRecognitionRepository nameRecognitionRepository;

  NameRecognitionBloc()
      : nameRecognitionRepository = NameRecognitionRepository(ApiClient()),
        super(NameRecognitionInitial()) {
    on<NameRecognitionEvent>((event, emit) {});

    on<NameRecognitionCreateEvent>(_onNameRecognitionCreateEvent);
    on<NameRecognitionGetByStudentIdEvent>(
        _onNameRecognitionGetByStudentIdEvent);
  }

  Future<void> _onNameRecognitionCreateEvent(NameRecognitionCreateEvent event,
      Emitter<NameRecognitionState> emit) async {
    emit(NameRecognitionCreating());
    try {
      final result = await nameRecognitionRepository
          .createNameRecognition(event.nameRecognitionModel);
      emit(NameRecognitionCreated(nameRecognition: result!));
    } catch (e) {
      String errorMessage = e.toString();
      if (e.toString().contains('HTTP 400')) {
        errorMessage = 'You already registered for this class';
      }
      emit(NameRecognitionCreatingError(message: errorMessage));
    }
  }

  Future<void> _onNameRecognitionGetByStudentIdEvent(
      NameRecognitionGetByStudentIdEvent event,
      Emitter<NameRecognitionState> emit) async {
    emit(NameRecognitionLoading());
    try {
      final result = await nameRecognitionRepository
          .getListNameRecognitionByStudentID(event.studentId);
      emit(NameRecognitionLoaded(nameRecognition: result));
    } catch (e) {
      emit(NameRecognitionError(message: e.toString()));
    }
  }
}
