part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class UserLoadSuccess extends ProfileState {
  final User user;

  const UserLoadSuccess({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserLoadSuccess { user: $user }';
}

class ProfileError extends ProfileState {}

class ProfileUpdating extends ProfileState {}

class CheckPasswordSuccesss extends ProfileState {
  final bool status;
  const CheckPasswordSuccesss({required this.status});
}

class ProfileUpdated extends ProfileState {
  final bool status;
  const ProfileUpdated({required this.status});
}
