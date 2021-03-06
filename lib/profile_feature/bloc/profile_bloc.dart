import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/core/models/user_login.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/repository/user_repository.dart';

import '../../main.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  StreamSubscription? _servicesSubscription;

  ProfileBloc({required this.userRepository}) : super(ProfileInitial());

  String mockUserId = "6129f203748ba19d14a2c1df";

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoadFormPhone) {
      yield* _mapUserFormPhoneLoadToState();
    } else if (event is CarUpdate) {
      yield* _mapUserUpdateToState(event.user);
    } else if (event is CheckPassword) {
      yield* _checkPasswordToState(event.userLogin);
    } else if (event is UserUpdateNoPassword) {
      yield* _mapUserUpdateNoPasswordToState(event.user, event.image);
    } else if (event is UserUpdatePassword) {
      yield* _mapUserUpdatePasswordToState(event.user);
    } else if (event is UploadImageProfile) {
      yield* _mapUserUpdatImageProfileToState(event.image);
    }
  }

  Stream<ProfileState> _mapServiceLoadToState() async* {
    try {
      final user = await this.userRepository.getUserInfo(id: mockUserId);
      yield UserLoadSuccess(user: user);
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _checkPasswordToState(UserLogin userLogin) async* {
    try {
      bool status =
          await this.userRepository.checkPassword(userLogin: userLogin);
      if (status == true) {
        yield CheckPasswordSuccesss(status: status);
      } else {
        yield CheckPasswordError(status: status);
      }
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapUserFormPhoneLoadToState() async* {
    try {
      final user = await this.userRepository.getUserInfoPhone();
      yield UserLoadSuccess(user: user);
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapUserUpdateToState(User user) async* {
    try {
      yield ProfileUpdating();
      final res = await this.userRepository.updateUser(user: user);
      yield ProfileUpdated(status: res);
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapUserUpdateNoPasswordToState(
      User user, File? image) async* {
    try {
      yield ProfileUpdating();
      final res = await this.userRepository.updateUserNoPassword(user: user);
      if (image != null) {
        await this.userRepository.updateUserImageProfile(image: image);
      }
      yield ProfileUpdated(status: res);
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapUserUpdatePasswordToState(User user) async* {
    try {
      yield ProfileUpdating();
      final res = await this.userRepository.updateUserPassword(user: user);
      yield ProfileUpdated(status: res);
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapUserUpdatImageProfileToState(File image) async* {
    try {
      final res =
          await this.userRepository.updateUserImageProfile(image: image);
      yield UploadImageSuccess();
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
