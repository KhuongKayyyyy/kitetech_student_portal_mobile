import 'package:bloc/bloc.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';
import 'package:kitetech_student_portal/data/respository/student_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final StudentRepository studentRepository;
  AuthenticationBloc(this.studentRepository) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationEventLogin>(_onAuthenticationEventLogin);
    on<AuthenticationEventLogout>(_onAuthenticationEventLogout);
  }

  Future<void> _onAuthenticationEventLogin(
      AuthenticationEventLogin event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationStateLoading());
    try {
      var appUser = await studentRepository.login(event.name, event.password);
      emit(AuthenticationStateLoggedIn(appUser: appUser));
    } catch (e) {
      emit(AuthenticationStateError(message: e.toString()));
    }
  }

  void _onAuthenticationEventLogout(
      AuthenticationEventLogout event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationStateLoggedOut());
  }
}
