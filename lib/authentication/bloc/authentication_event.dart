part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final UserDB userDB;

  const LoggedIn({required this.userDB});


  @override
  List<Object> get props => [userDB];

  @override
  String toString() => 'LoggedIn { user: ${userDB.phone} }';
}

class LoggedOut extends AuthenticationEvent {}
