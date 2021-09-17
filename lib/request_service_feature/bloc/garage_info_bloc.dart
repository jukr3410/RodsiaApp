import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/core/repository/service_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'garage_info_event.dart';
part 'garage_info_state.dart';

class GarageInfoBloc extends Bloc<GarageInfoEvent, GarageInfoState> {
  final GarageRepository garageRepository;
  final ServiceRepository serviceRepository;
  StreamSubscription? _servicesSubscription;

  GarageInfoBloc(
      {required this.garageRepository, required this.serviceRepository})
      : super(GarageInfoInitial());

  @override
  Stream<GarageInfoState> mapEventToState(
    GarageInfoEvent event,
  ) async* {
    if (event is GarageInfoLoad) {
      yield* _mapGarageInfoLoadToStat(event);
    }
  }

  Stream<GarageInfoState> _mapGarageInfoLoadToStat(
      GarageInfoLoad event) async* {
    try {
      yield GarageInfoLoading();
      final garage = await garageRepository.getGarageInfo(id: event.garageId);
      final services =
          await serviceRepository.getServiceByGarage(garageId: event.garageId);
      yield GarageLoadSuccess(garage, services);
    } catch (e) {
      logger.e(e);
      yield GarageInfoError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
