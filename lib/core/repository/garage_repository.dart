import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_api.dart';

class GarageRepository {
  final GarageApi garageApi;
  GarageRepository({required this.garageApi});

  Future<List<Garage>> getGarages() async {
    return await garageApi.getGarages();
  }
}
