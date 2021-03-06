import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_login.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';
import 'package:rodsiaapp/core/repository/user_repository.dart';
import '../../constants.dart';
import '../../main.dart';

class UserApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final userDao = UserDao();

  Future<User> getUserInfo({required String id}) async {
    final url = '$baseUrl/users/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    User user = User.fromJson(decodedJson);

    return user;
  }

  Future<User> getUserInfoPhone() async {
    UserDB userToken = await userDao.getUserToken();
    final url = '$baseUrl/users-phone/${userToken.phone}';

    final response = await http.get(Uri.parse(url));
    logger.d('res: ${response.body}');
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);

    User user = User.fromJson(decodedJson);
    logger.d(user.toJson());

    return user;
  }

  Future<bool> updateUser({required User user}) async {
    final url = '$baseUrl/users';
    final msg = jsonEncode(user.toJson());
    final response =
        await http.patch(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> updateUserNoPassword({required User user}) async {
    final url = '$baseUrl/users-no-password';
    final msg = jsonEncode(user.toJson());
    final response =
        await http.patch(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> updateUserPassword({required User user}) async {
    final url = '$baseUrl/users-password';
    final msg = jsonEncode(user.toJson());
    final response =
        await http.patch(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> updateUserImage({required File image}) async {
    UserDB userToken = await userDao.getUserToken();
    final url = '$baseUrl/image-uploads/user/${userToken.phone}';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headersUpload = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
      ),
    );
    request.headers.addAll(headersUpload);
    logger.d("request: " + request.toString());
    try {
      var res = await request.send();
      var data = await res.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .first;

      logger.d('Response:\n$data');

      if (res.statusCode != 200) {
        logger.e(res);
        return false;
      }
      return true;
    } catch (e, stacktrace) {
      logger.d('Http exception:\nInstance of: ${e.runtimeType}\nMessage: ${e}');
      logger.d('Http stacktrace:\n$stacktrace');
      return false;
    }
  }

  Future<bool> updateUserProfile({required File image}) async {
    UserDB userToken = await userDao.getUserToken();
    final url = '$baseUrl/image-uploads/user/${userToken.phone}';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headersUpload = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
      ),
    );
    request.headers.addAll(headersUpload);
    logger.d("request: " + request.toString());
    try {
      var res = await request.send();
      var data = await res.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .first;

      logger.d('Response:\n$data');

      if (res.statusCode != 200) {
        logger.e(res);
      }
      return true;
    } catch (e, stacktrace) {
      logger.d('Http exception:\nInstance of: ${e.runtimeType}\nMessage: ${e}');
      logger.d('Http stacktrace:\n$stacktrace');
      return false;
    }
  }

  Future<bool> checkUsedNumberPhone({required User user}) async {
    final url = '$baseUrl/auth/phoneCheck-User';
    final msg = jsonEncode(user.toJson());
    logger.d("checkUsedNumberPhone msg: ${msg}");
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d("isExists: ${decodedJson['success']}");

    if (decodedJson["success"] == false) {
      logger.d("phone number not exists");
      return false;
    }

    return true;
  }

  Future<bool> addUser({required User user}) async {
    final url = '$baseUrl/auth/registerUser';
    final msg = jsonEncode(user.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      final decodedJson = jsonDecode(response.body);
      logger.d("$decodedJson");
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }

    final decodedJson = jsonDecode(response.body);
    logger.d("$decodedJson");

    return true;
  }

  Future<bool> requestSendOtpUser({required User user}) async {
    final url = '$baseUrl/auth/sendOtpUser';
    final msg = jsonEncode(user.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> verifyOtpUser({required User user}) async {
    logger.d("User Verify: ${user.otp}");
    final url = '$baseUrl/auth/verifyOtpUser';
    final msg = jsonEncode(user.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d("isSuccess: ${decodedJson['success']}");

    if (decodedJson["success"] == false) {
      logger.d("verify failed");
      return false;
    }

    return true;
  }

  Future<bool> checkPassword({required UserLogin userLogin}) async {
    final url = '$baseUrl/auth/loginUser';
    final msg = jsonEncode(userLogin.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      // final decodedJson = jsonDecode(response.body);
      // logger.d("$decodedJson");

      return false;
    }
    return true;
  }

  Future<Token> getTokenLogin({required UserLogin userLogin}) async {
    final url = '$baseUrl/auth/loginUser';
    final msg = jsonEncode(userLogin.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      final decodedJson = jsonDecode(response.body);
      logger.d("$decodedJson");
      //return '';
      throw new Exception('There was a problem ${response.statusCode}');
    }

    final decodedJson = jsonDecode(response.body);
    logger.d("$decodedJson");
    Token token = Token.fromJson(decodedJson);
    logger.d("$token");
    return token;
  }
}
