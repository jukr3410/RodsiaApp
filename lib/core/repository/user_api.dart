import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
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
    User user = decodedJson;

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

  Future<bool> checkUsedNumberPhone({required User user}) async {
    final url = '$baseUrl/auth/phoneCheck-User';
    final msg = jsonEncode(user.toJson());
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

  // ไปทำเส้น api ก่อน
  // Future<bool> updateCar({required User user}) async {
  //   logger.d('${user.cars}');
  //   final msg = jsonEncode(user.cars);
  //   final url = '$baseUrl/users/${user.id}/update-car';
  //   final response =
  //       await http.post(Uri.parse(url), body: msg, headers: headers);
  //   if (response.statusCode != 200) {
  //     logger.e(response);
  //     return false;
  //     //throw new Exception('There was a problem ${response.statusCode}');
  //   }
  //   return true;
  // }

}
