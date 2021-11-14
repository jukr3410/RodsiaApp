import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_api.dart';

class GarageRepository {
  GarageApi garageApi = GarageApi();
  static final GarageRepository _garageRepository = GarageRepository._();

  GarageRepository._();

  factory GarageRepository() {
    return _garageRepository;
  }

  Future<List<Garage>> getGarages({required int page}) async {
    return await garageApi.getGarages(page: page);
  }

  Future<List<Garage>> getByGaragesName(
      {required int page, required String name}) async {
    return await garageApi.getByGaragesName(name: name);
  }

  Future<Garage> getGarageInfo({required String id}) async {
    return await garageApi.getGarageInfo(id: id);
  }
}
