import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/user_login.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';

import 'user_api.dart';

class UserRepository {
  final UserApi userApi = UserApi();
  final userDao = UserDao();
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

  Future<bool> addUser({required User user}) async {
    return await userApi.addUser(user: user);
  }

  Future<bool> checkUsedNumberPhone({required User user}) async {
    return await userApi.checkUsedNumberPhone(user: user);
  }

  Future<UserDB> authenticate({
    required String phone,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(phone: phone, password: password);
    Token token = await userApi.getTokenLogin(userLogin: userLogin);
    UserDB userDB = UserDB(
      id: 0,
      phone: phone,
      token: token.token,
    );
    return userDB;
  }

  Future<void> persistToken({required UserDB userDB}) async {
    // write token with the user to the database
    await userDao.createUser(userDB);
  }

  Future<void> deleteToken({required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }

  Future<UserDB> getToken() async {
    UserDB result = await userDao.getToken(0);
    return result;
  }
}
