part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoad extends ProfileEvent {}

class ProfileLoadFormPhone extends ProfileEvent {}

class CarUpdate extends ProfileEvent {
  final User user;

  const CarUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'CarUpdate {user: $user}';
}

class UserUpdate extends ProfileEvent {
  final User user;

  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserUpdate {user: $user}';
}

class UserUpdateNoPassword extends ProfileEvent {
  final File? image;
  final User user;

  const UserUpdateNoPassword({required this.user, this.image});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserUpdate {user: $user}';
}

class UserUpdatePassword extends ProfileEvent {
  final User user;

  const UserUpdatePassword(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserUpdate {user: $user}';
}

class CheckPassword extends ProfileEvent {
  final UserLogin userLogin;
  const CheckPassword({required this.userLogin});
}

class UploadImageProfile extends ProfileEvent {
  final File image;
  const UploadImageProfile({required this.image});
}
