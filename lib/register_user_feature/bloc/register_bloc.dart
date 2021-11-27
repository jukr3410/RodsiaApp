import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/repository/user_api.dart';
import 'package:rodsiaapp/core/repository/user_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  StreamSubscription? _usersSubscription;

  UserApi userApi = UserApi();

  RegisterBloc({required this.userRepository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterAddNumber) {
      yield* _mapRegisterAddNumberToState(event);
    } else if (event is RegisterVerifyOtp) {
      yield* _mapRegisterVerifyOtpToState(event);
    } else if (event is RegisterSendOtp) {
      yield* _mapRegisterSendOtpToState(event);
    } else if (event is RegisterButtonPressed) {
      yield* _mapRegisterButtonPressedToState(event);
    } else if (event is ResetButtonPressed) {
      yield* _mapResetButtonPressedToState(event);
    } else if (event is ResetCheckPhoneNumber) {
      yield* _mapResetCheckPhoneNumberToState(event);
    } else {
      yield RegisterInitial();
    }
  }

  Stream<RegisterState> _mapRegisterAddNumberToState(
      RegisterAddNumber event) async* {
    try {
      yield RegisterLoading();
      logger.d("Phone: ${event.user.phone}");
      var isPhoneNumberExist =
          await this.userRepository.checkUsedNumberPhone(user: event.user);
      logger.d("isPhoneNumberExist: $isPhoneNumberExist");

      if (isPhoneNumberExist == false) {
        var addedNumber = await this.userRepository.addUser(user: event.user);
        logger.d("addedNumber: $addedNumber");
        if (addedNumber == true) {
          yield RegisterAddNumberSuccess();
        } else if (addedNumber == false) {
          yield RegisterError();
        }
        //yield RegisterAddNumberSuccess();
      } else if (isPhoneNumberExist == true) {
        yield RegisterAddNumberExist();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapRegisterVerifyOtpToState(
      RegisterVerifyOtp event) async* {
    try {
      yield RegisterLoading();

      var isSuccess = await this.userRepository.verifyOtpUser(user: event.user);
      if (isSuccess == true) {
        yield RegisterVerifySuccess();
      } else {
        yield RegisterVerifyFailed();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapRegisterSendOtpToState(
      RegisterSendOtp event) async* {
    try {
      yield RegisterLoading();

      var isSendOtp =
          await this.userRepository.requestSendOtpUser(user: event.user);
      logger.d("RegisterSendOtp: $isSendOtp");
      if (isSendOtp == true) {
        yield RegisterSendVerifyOtpSuccess();
      } else {
        yield RegisterError();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapRegisterButtonPressedToState(
      RegisterButtonPressed event) async* {
    try {
      yield RegisterLoading();

      var isRegisted = await this.userRepository.updateUser(user: event.user);
      if (isRegisted == true) {
        yield RegisterSuccess();
      } else {
        yield RegisterError();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapResetCheckPhoneNumberToState(
      ResetCheckPhoneNumber event) async* {
    try {
      yield ResetLoading();
      logger.d("Phone: ${event.user.phone}");
      var isPhoneNumberExist =
          await this.userRepository.checkUsedNumberPhone(user: event.user);
      logger.d("isPhoneNumberExist: $isPhoneNumberExist");

      if (isPhoneNumberExist == false) {
        yield ResetNumberNotExist();
      } else if (isPhoneNumberExist == true) {
        yield ResetNumberExist();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapResetButtonPressedToState(
      ResetButtonPressed event) async* {
    try {
      yield ResetLoading();

      var isReseted = await this.userRepository.updateUser(user: event.user);
      if (isReseted == true) {
        yield ResetSuccess();
      } else {
        yield ResetError();
      }
    } catch (e) {
      logger.e(e);
      yield ResetError();
    }
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}
