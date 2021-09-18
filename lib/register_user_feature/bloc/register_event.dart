part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final User user;

  const RegisterButtonPressed({required this.user});

  @override
  String toString() => 'Register {user: $user}';
}
