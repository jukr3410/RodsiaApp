import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/core/services/geo_location_service.dart';
import 'package:rodsiaapp/core/services/marker.dart';
import 'package:rodsiaapp/main.dart';

part 'garage_event.dart';
part 'garage_state.dart';

class GarageListBloc extends Bloc<GarageListEvent, GarageListState> {
  final GarageRepository garagerRepository;
  final geoService = GeoLocatorService();
  final markerService = MarkerService();
  int page = 1;

  bool isFetching = false;

  GarageListBloc({required this.garagerRepository})
      : super(GarageListInitialState());

  @override
  Stream<GarageListState> mapEventToState(
    GarageListEvent event,
  ) async* {
    if (event is GarageListFetchEvent) {
      try {
        yield GarageListLoadingState(message: mLoading);
        final garages = await garagerRepository.getGarages(page: page);
        if (garages.isNotEmpty) {
          yield GarageListSuccessState(garages: garages);
          page++;
        } else {
          yield GarageListEmptyState();
        }
      } catch (e) {
        logger.e(e);
        yield GarageListErrorState(error: mError);
      }
    } else if (event is GetCurrentLocation) {
      yield* _mapGetCurrentLocationToState();
    } else if (event is ShowGarageInfo) {
      yield* _mapShowGarageInfoToState(event);
    }
  }

  Stream<GarageListState> _mapGetCurrentLocationToState() async* {
    try {
      yield MapLoading();
      final position = await geoService.getLocation();
      yield CurrentLocationSuccess(position: position);
    } catch (e) {
      logger.e(e);
      yield MapError();
    }
  }

  Stream<GarageListState> _mapShowGarageInfoToState(
      ShowGarageInfo event) async* {
    yield ShowGarageInfoSuccess(garage: event.garage);
  }
}
