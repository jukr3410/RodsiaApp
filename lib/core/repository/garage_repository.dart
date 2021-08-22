import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_api.dart';

class GarageRepository {
  GarageApi? garageApi;
  //GarageRepository({this.garageApi});

  Future<List<Garage>> getGarages({required int page}) async {
    return await garageApi!.getGarages(page: page);
  }

  Future<List<Garage>> getByGaragesName(
      {required int page, required String name}) async {
    return await garageApi!.getByGaragesName(page: page, name: name);
  }

  Future<Garage> getGarageInfo({required String id}) async {
    return await garageApi!.getGarageInfo(id: id);
  }
}
