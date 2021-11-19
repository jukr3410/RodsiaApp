import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'dart:convert';
import 'package:rodsiaapp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';

import '../../main.dart';

class RequestServiceApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final userDao = UserDao();

  Future<String> createRequestService(
      {required RequestServiceAdd requestServiceAdd}) async {
    UserDB userToken = await userDao.getUserToken();
    logger.d('userToken phone: ${userToken.phone}');
    logger.d('userToken id: ${userToken.user_id}');

    requestServiceAdd.user = userToken.user_id!;
    requestServiceAdd.status = waitingForConfirm;

    logger.d('${requestServiceAdd.toJson()}');
    final msg = jsonEncode(requestServiceAdd.toJson());
    final url = '$baseUrl/request-services';
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response.body);
      return response.body;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    logger.d('createRequestService api: ${response.body}');
    final decodedJson = jsonDecode(response.body);

    String requestServiceId = decodedJson['requestServiceId'];
    logger.d('createRequestService api requestServiceId: ${requestServiceId}');
    return requestServiceId;
  }

  Future<bool> removeRequestService({required String id}) async {
    final url = '$baseUrl/request-services/$id';
    final response = await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d(decodedJson);

    return true;
  }

  Future<RequestService> getRequestService({required String id}) async {
    final url = '$baseUrl/request-services/$id';
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d(decodedJson);
    RequestService requestService = RequestService.fromJson(decodedJson);
    logger.d(requestService);
    return requestService;
  }

  Future<List<RequestService>> getRequestServiceByUserId(
      {required String id}) async {
    List<RequestService> requestServices = [];
    final url = '$baseUrl/request-services/user/$id';
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    logger.d(decodedJson);
    requestServices = decodedJson
        .map((decodedJson) => RequestService.fromJson(decodedJson))
        .toList();
    for (var i = 0; i < requestServices.length; i++) {
      List<Service> services = [];
      final urlService =
          '$baseUrl/garage/${requestServices[i].service.garage.id}/services';
      final responseService =
          await http.get(Uri.parse(urlService), headers: headers);
      if (responseService.statusCode != 200) {
        print('Exception service: ${responseService.statusCode}');
        throw new Exception(
            'There was a service problem ${responseService.statusCode}');
      }
      final decodedJsonService = jsonDecode(responseService.body) as List;
      services = decodedJsonService
          .map((decodedJsonService) => Service.fromJson(decodedJsonService))
          .toList();
      requestServices[i].service.garage.services = services;
    }
    logger.d(requestServices);

    return requestServices;
  }
}
