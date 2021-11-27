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

class RegisterCheckPhoneNumber extends RegisterEvent {
  final String phoneNumber;

  const RegisterCheckPhoneNumber({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() => 'RegisterCheckPhoneNumber phoneNumber: ${phoneNumber}';
}

class RegisterAddNumber extends RegisterEvent {
  final User user;

  const RegisterAddNumber({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'RegisterAddNumber user: ${user.toJson()}';
}

class RegisterVerifyOtp extends RegisterEvent {
  final User user;

  const RegisterVerifyOtp({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Register user: ${user}';
}

class RegisterSendOtp extends RegisterEvent {
  final User user;

  const RegisterSendOtp({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'RegisterSendOtpAgian user: ${user}';
}

class ResetCheckPhoneNumber extends RegisterEvent {
  final User user;

  const ResetCheckPhoneNumber({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'RegisterAddNumber user: ${user.toJson()}';
}

class ResetButtonPressed extends RegisterEvent {
  final User user;

  const ResetButtonPressed({required this.user});

  @override
  String toString() => 'Register {user: $user}';
}
