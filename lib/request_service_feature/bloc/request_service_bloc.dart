import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/repository/request_service_api.dart';
import 'package:rodsiaapp/core/repository/request_service_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'request_service_event.dart';
part 'request_service_state.dart';

class RequestServiceBloc
    extends Bloc<RequestServiceEvent, RequestServiceState> {
  final RequestServiceRepository requestServiceRepository;
  StreamSubscription? _servicesSubscription;

  RequestServiceApi requestServiceApi = RequestServiceApi();

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
      String requestServiceId = await this
          .requestServiceRepository
          .createRequestService(requestServiceAdd: event.requestServiceAdd);
      yield CreatedRequestService(requestServiceId: requestServiceId);
    } catch (e) {
      logger.e(e);
      yield CreateRequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapLoadRequestServiceToState(
      LoadRequestService event) async* {
    try {
      yield RequestServiceLoading();
      while (_isNotConfirmed) {
        await Future.delayed(Duration(milliseconds: 500));
        final requestService = await this
            .requestServiceRepository
            .getRequestService(id: event.requestServiceId);
        logger.d("GarageConfirm: ${requestService.confirmRequest}");
        yield RequestServiceLoadSuccess(requestServiceAdd: requestService);
        if (requestService.confirmRequest == false) {
          yield RequestServiceWaiting();
        } else {
          _isNotConfirmed = false;
          yield RequestServiceGarageConfirmed();
        }
      }
    } catch (e) {
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapTrackingServiceToState(
      TrackingRequestService event) async* {
    try {
      yield RequestServiceLoading();
      while (_isNotCompleted) {
        await Future.delayed(Duration(milliseconds: 1000));
        final requestService = await this
            .requestServiceRepository
            .getRequestService(id: event.requestServiceId);
        logger.d("GarageConfirm: ${requestService.confirmRequest}");
        yield RequestServiceLoadSuccess(requestServiceAdd: requestService);
        if (requestService.status != "เสร็จสิ้น") {
          yield RequestServiceInService();
        } else {
          _isNotConfirmed = false;
          yield RequestServiceComleted();
        }
      }
    } catch (e) {
      yield RequestServiceError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
