import 'package:http/http.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';

class EditCarAndIndex {
  Car carOld;
  Car carNew;
  int indexCar;
  EditCarAndIndex(
      {required this.carOld, required this.carNew, required this.indexCar});
}

class EditCar {
  Car carOld;
  Car carNew;
  EditCar({
    required this.carOld,
    required this.carNew,
  });
}

class EditCarNoNewCar {
  Car carOld;
  int index;
  EditCarNoNewCar({
    required this.carOld,
    required this.index,
  });
}
