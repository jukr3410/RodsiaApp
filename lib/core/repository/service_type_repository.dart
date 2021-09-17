import 'package:rodsiaapp/core/models/services_type_model.dart';

import 'service_type_api.dart';

class ServiceTypeRepository {
  ServiceTypeApi serviceTypeApi = ServiceTypeApi();
  static final ServiceTypeRepository _serviceTypeRepository =
      ServiceTypeRepository._();

  ServiceTypeRepository._();

  factory ServiceTypeRepository() {
    return _serviceTypeRepository;
  }

  Future<List<ServiceType>> getServiceTypes() async {
    return await serviceTypeApi.getServiceTypes();
  }
}
