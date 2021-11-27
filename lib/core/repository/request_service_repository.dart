import 'dart:io';

import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/models/review_add_model.dart';

import 'request_service_api.dart';

class RequestServiceRepository {
  RequestServiceApi requestServiceApi = RequestServiceApi();
  static final RequestServiceRepository _requestServiceRepository =
      RequestServiceRepository._();

  RequestServiceRepository._();

  factory RequestServiceRepository() {
    return _requestServiceRepository;
  }

  Future<RequestService> getRequestService({required String id}) async {
    return await requestServiceApi.getRequestService(id: id);
  }

  Future<List<RequestService>> getRequestServiceByUserId() async {
    return await requestServiceApi.getRequestServiceByUserId();
  }

  Future<List<RequestService>> getRequestServiceListWithStatus(
      {required String status}) async {
    return await requestServiceApi.getRequestServiceListWithStatus(
        status: status);
  }

  Future<RequestService> createRequestService(
      {required RequestServiceAdd requestServiceAdd}) async {
    return await requestServiceApi.createRequestService(
        requestServiceAdd: requestServiceAdd);
  }

  Future<bool> removeRequestService({required String id}) async {
    return await requestServiceApi.removeRequestService(id: id);
  }

  Future<bool> uploadRequestServiceImage(
      {required String id, required File image}) async {
    return await requestServiceApi.uploadRequestServiceImage(
        image: image, id: id);
  }
}
