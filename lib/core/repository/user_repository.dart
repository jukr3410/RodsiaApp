import 'package:rodsiaapp/core/models/user_model.dart';

import 'user_api.dart';

class UserRepository {
  UserApi userApi = UserApi();
  static final UserRepository _userRepository = UserRepository._();

  UserRepository._();

  factory UserRepository() {
    return _userRepository;
  }

  Future<User> getUserInfo({required String id}) async {
    return await userApi.getUserInfo(id: id);
  }

  Future<bool> updateUser({required User user}) async {
    return await userApi.updateUser(user: user);
  }
}
