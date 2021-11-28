import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/distance_matrix.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/models/review_add_model.dart';
import 'package:rodsiaapp/core/repository/request_service_api.dart';
import 'package:rodsiaapp/core/repository/request_service_repository.dart';
import 'package:rodsiaapp/core/services/geo_location_service.dart';
import 'package:rodsiaapp/main.dart';

part 'request_service_event.dart';
part 'request_service_state.dart';

class RequestServiceBloc
    extends Bloc<RequestServiceEvent, RequestServiceState> {
  final RequestServiceRepository requestServiceRepository;
  StreamSubscription? _servicesSubscription;

  RequestServiceApi requestServiceApi = RequestServiceApi();
  final geoService = GeoLocatorService();

  RequestServiceBloc({required this.requestServiceRepository})
      : super(RequestServiceInitial());

  bool _isNotConfirmed = true;
  bool _isNotCompleted = true;

  @override
  Stream<RequestServiceState> mapEventToState(
    RequestServiceEvent event,
  ) async* {
    if (event is CreateRequestService) {
      yield* _mapCreateRequestServiceToState(event);
    } else if (event is GetCurrentLocationAndAddress) {
      yield* _mapGetCurrentLocationAndAddressToState(event);
    } else if (event is CancelRequestService) {
      yield* _mapCancelRequestServiceToState(event);
    } else if (event is LoadRequestService) {
      yield* _mapLoadRequestServiceToState(event);
    } else if (event is TrackingRequestService) {
      yield* _mapTrackingServiceToState(event);
    } else if (event is RequestServiceInitial) {
      yield RequestServiceInitial();
    }
  }

  Stream<RequestServiceState> _mapCreateRequestServiceToState(
      CreateRequestService event) async* {
    try {
      yield CreatingRequestService();
      logger.d("_mapCreateRequestServiceToState: ");
      logger.d(event.requestServiceAdd);
      RequestService requestService = await this
          .requestServiceRepository
          .createRequestService(requestServiceAdd: event.requestServiceAdd);
      logger.d(requestService.toJson());
      if (event.images != null) {
        for (var i = 0; i < event.images!.length; i++) {
          await this.requestServiceRepository.uploadRequestServiceImage(
              id: requestService.id, image: event.images![i]);
        }
      }
      yield CreatedRequestService(requestService: requestService);
    } catch (e) {
      logger.e(e);
      yield CreateRequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapCancelRequestServiceToState(
      CancelRequestService event) async* {
    try {
      yield RequestServiceLoading();
      logger.d("_mapCancelRequestServiceToState: ");
      logger.d(event.requestServiceId);
      await this
          .requestServiceRepository
          .removeRequestService(id: event.requestServiceId);
      yield CanceledRequestService();
    } catch (e) {
      logger.e(e);
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState>  _mapLoadRequestServiceToState(
      LoadRequestService event) async* {
    try {
      yield RequestServiceLoading();
      while (_isNotConfirmed) {
        await Future.delayed(Duration(milliseconds: 500));
        final requestService = await this
            .requestServiceRepository
            .getRequestService(id: event.requestServiceId);
        logger.d("GarageConfirm: ${requestService.status}");
        yield RequestServiceLoadSuccess(requestService: requestService);

        if (requestService.status == denyRequestService) {
          _isNotConfirmed = false;
          yield RequestServiceGarageDeny();
        } else if (requestService.status == confirmedRequestService) {
          _isNotConfirmed = false;
          yield RequestServiceGarageConfirmed(requestService: requestService);
        } else {
          yield RequestServiceWaiting();
        }
      }
    } catch (e) {
      logger.d("RequestServiceError: ${e}");
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapTrackingServiceToState(
      TrackingRequestService event) async* {
    try {
      yield RequestServiceLoading();
      while (_isNotCompleted) {
        await Future.delayed(Duration(milliseconds: 3000));

        final requestService = await this
            .requestServiceRepository
            .getRequestService(id: event.requestServiceId);

        final distanceMatrix = await this.geoService.getDistanceMatrix(
            startLatitude: double.parse(requestService.geoLocationUser.lat),
            startLongitude: double.parse(requestService.geoLocationUser.long),
            endLatitude: double.parse(requestService.geoLocationGarage.lat),
            endLongitude: double.parse(requestService.geoLocationGarage.long));

        logger.d("GarageConfirm: ${requestService.confirmRequest}");
        yield RequestServiceLoadSuccess(
            requestService: requestService, distanceMatrix: distanceMatrix);
        if (requestService.status != completeRequestService) {
          yield RequestServiceInService();
        } else {
          _isNotCompleted = false;
          yield RequestServiceComleted();
        }
      }
    } catch (e) {
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapGetCurrentLocationAndAddressToState(
      GetCurrentLocationAndAddress event) async* {
    try {
      yield RequestServiceLoading();
      final position = await geoService.getLocation();
      final address =
          await geoService.getAddress(position.latitude, position.longitude);
      yield CurrentLocationAndAddressSuccess(
          position: position, address: address);
    } catch (e) {
      logger.e(e);
      yield RequestServiceError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
