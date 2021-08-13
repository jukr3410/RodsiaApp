import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';

part 'garage_event.dart';
part 'garage_state.dart';

class GarageBloc extends Bloc<GarageEvent, GarageState> {
  final Garagerepository garagerRpository;
  bool isFetching = false;

  GarageBloc({required this.garagerRpository}) : super(GarageInitialState());

  @override
  Stream<GarageState> mapEventToState(
    GarageEvent event,
  ) async* {
    if (event is GarageFetchEvent) {
      yield GarageLoadingState(message: "Loading Garages");
      final response = await garagerRpository.getGarages();
      if (response is http.Response) {
        if (response.statusCode == 200) {
          final garages = jsonDecode(response.body) as List;
          yield GarageSuccessState(
              garages:
                  garages.map((garages) => Garage.fromJson(garages)).toList());
        } else {
          yield GarageErrorState(error: response.body);
        }
      } else if (response is String) {
        yield GarageErrorState(error: response);
      }
    }
  }
}
