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
