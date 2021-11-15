import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';
import 'package:rodsiaapp/core/repository/user_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.userRepository, required this.authenticationBloc})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedInToState(event);
    }
  }

  Stream<LoginState> _mapLoginButtonPressedInToState(
      LoginButtonPressed event) async* {
    yield LoginLoading();

    try {
      final UserDB userDB = await userRepository.authenticate(
        phone: event.phone,
        password: event.password,
      );
      logger.d(
        'userDB Token: ${userDB.token}',
      );

      authenticationBloc.add(LoggedIn(userDB: userDB));

      //yield LoginInitial();
      yield LoginSuccess();
    } catch (error) {
      yield LoginFaliure(error: "หมายเลขโทรศัพท์หรือรหัสผ่านไม่ถูกต้อง");
    }
  }
}
