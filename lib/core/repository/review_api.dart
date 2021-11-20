import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/review_add_model.dart';
import 'package:rodsiaapp/main.dart';

class ReviewApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final userDao = UserDao();

  Future<bool> createReview({required ReviewAdd reviewAdd}) async {
    final url = '$baseUrl/reviews';
    final msg = jsonEncode(reviewAdd.toJson());
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
}
