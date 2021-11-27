import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/repository/request_service_api.dart';
import 'package:rodsiaapp/core/repository/request_service_repository.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';

part 'request_service_event.dart';
part 'request_service_state.dart';

class RequestServiceBloc
    extends Bloc<RequestServiceEvent, RequestServiceState> {
  final RequestServiceRepository requestServiceRepository;
  StreamSubscription? _servicesSubscription;

  RequestServiceApi serviceApi = RequestServiceApi();

  RequestServiceBloc({required this.requestServiceRepository})
      : super(RequestServiceInitial());

  @override
  Stream<RequestServiceState> mapEventToState(
    RequestServiceEvent event,
  ) async* {
    if (event is RequestServiceLoad) {
      yield* _mapRequestServiceLoadToState();
    } else if (event is RequestServiceWithStatus) {
      yield* _mapRequestServiceLoadWithStatusToState(event.status);
    } else if (event is RequestServiceInitializeEvent) {
      yield RequestServiceInitial();
    }
  }

  Stream<RequestServiceState> _mapRequestServiceLoadToState() async* {
    try {
      final requestServices =
          await this.requestServiceRepository.getRequestServiceByUserId();
      yield RequestServicesLoadSuccess(requestServices: requestServices);
    } catch (e) {
      logger.e(e);
      yield RequestServicesError();
    }
  }

  Stream<RequestServiceState> _mapRequestServiceLoadWithStatusToState(
      String status) async* {
    try {
      final requestServices = await this
          .requestServiceRepository
          .getRequestServiceListWithStatus(status: status);
      yield RequestServicesLoadSuccess(requestServices: requestServices);
    } catch (e) {
      logger.e(e);
      yield RequestServicesError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
