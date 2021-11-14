import 'package:rodsiaapp/core/models/service_model.dart';

import 'service_api.dart';

class ServiceRepository {
  ServiceApi serviceApi = ServiceApi();
  static final ServiceRepository _serviceRepository = ServiceRepository._();

  ServiceRepository._();

  factory ServiceRepository() {
    return _serviceRepository;
  }

  Future<List<Service>> getServiceByGarage({required String garageId}) async {
    return await serviceApi.getServiceByGarage(garageId: garageId);
  }

  Future<Service> getServiceById({required String serviceId}) async {
    return await serviceApi.getServiceById(serviceId: serviceId);
  }
}
