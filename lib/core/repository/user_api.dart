import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import '../../constants.dart';
import '../../main.dart';

class GarageApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<User> getUser({required String id}) async {
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
    final url = '$baseUrl/user/${user.id}';
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

  // ไปทำเส้น api ก่อน
  Future<bool> addCar({required String userId, required Car car}) async {
    logger.d('${car.toJson()}');
    final msg = jsonEncode(car.toJson());
    final url = '$baseUrl/users/${userId}/add-car';
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }
}