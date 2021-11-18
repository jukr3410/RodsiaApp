import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';

import 'request_service_api.dart';

class RequestServiceRepository {
  RequestServiceApi requestServiceApi = RequestServiceApi();
  static final RequestServiceRepository _requestServiceRepository =
      RequestServiceRepository._();

  RequestServiceRepository._();

  factory RequestServiceRepository() {
    return _requestServiceRepository;
  }

  Future<RequestServiceAdd> getRequestService({required String id}) async {
    return await requestServiceApi.getRequestService(id: id);
  }

  Future<List<RequestService>> getRequestServiceByUserId(
      {required String id}) async {
    return await requestServiceApi.getRequestServiceByUserId(id: id);
  }

  Future<String> createRequestService(
      {required RequestServiceAdd requestServiceAdd}) async {
    return await requestServiceApi.createRequestService(
        requestServiceAdd: requestServiceAdd);
  }

  Future<bool> removeRequestService({required String id}) async {
    return await requestServiceApi.removeRequestService(id: id);
  }
}
