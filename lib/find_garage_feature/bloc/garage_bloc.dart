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
  int page = 1;

  GarageBloc({required this.garagerRpository})
      : super(GarageListInitialState());

  @override
  Stream<GarageState> mapEventToState(
    GarageEvent event,
  ) async* {
    final currentState = state;
    if (event is GarageFetchEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is GarageListInitialState) {
          yield GarageListLoadingState(message: mLoading);
          final garages = await garagerRpository.getGarages(page: page);
          yield GarageListSuccessState(garages: garages, hasReachedMax: false);
          return;
        }
        if (currentState is GarageListSuccessState) {
          final garages = await garagerRpository.getGarages(page: ++page);
          yield garages.isEmpty
              ? currentState.copyWith(garages: [], hasReachedMax: true)
              : GarageListSuccessState(garages: garages, hasReachedMax: false);
        }
      } catch (e) {
        print(e);
        yield GarageListErrorState(error: mError);
      }
    }
  }

  bool _hasReachedMax(GarageState state) =>
      state is GarageListSuccessState && state.hasReachedMax;
}
