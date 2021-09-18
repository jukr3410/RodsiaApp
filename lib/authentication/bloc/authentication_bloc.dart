import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';
import 'package:rodsiaapp/core/repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final bool hasToken = await userRepository.hasToken();

    if (hasToken) {
      yield AuthenticationAuthenticated();
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    yield AuthenticationLoading();

    await userRepository.persistToken(userDB: event.userDB);

    yield AuthenticationAuthenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthenticationLoading();

    await userRepository.deleteToken(id: 0);

    yield AuthenticationUnauthenticated();
  }
}
