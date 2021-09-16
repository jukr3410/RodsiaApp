import 'package:rodsiaapp/core/models/geo_location_model.dart';
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

  Future<RequestService> getRequestService({required String id}) async {
    return await requestServiceApi.getRequestService(id: id);
  }

  Future<bool> updateGeoLocation(
      {required String requestId, required GeoLocation geoLocation}) async {
    return await requestServiceApi.updateGeoLocation(
        requestId: requestId, geoLocation: geoLocation);
  }
}
