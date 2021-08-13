import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';

part 'garage_event.dart';
part 'garage_state.dart';

class GarageBloc extends Bloc<GarageEvent, GarageState> {
  final GarageRepository garagerRpository;

  GarageBloc({required this.garagerRpository}) : super(GarageInitialState());

  @override
  Stream<GarageState> mapEventToState(
    GarageEvent event,
  ) async* {
    if (event is GarageFetchEvent) {
      try {
        final garages = await garagerRpository.getGarages();
        yield GarageSuccessState(garages: garages);
      } catch (e) {
        print(e);
        yield GarageErrorState(error: messageError);
      }
    }
  }
}
