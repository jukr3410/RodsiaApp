import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/core/repository/service_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;

  ServiceBloc({required this.serviceRepository}) : super(ServiceInitialState());

  @override
  Stream<ServiceState> mapEventToState(
    ServiceEvent event,
  ) async* {
    if (event is ServiceFetchEvent) {
      try {
        final service =
            await serviceRepository.getServiceById(serviceId: event.serviceId);
        logger.d(service);
        yield ServiceSuccessState(service: service);
      } catch (e) {
        print(e);
        yield ServiceErrorState(error: mNotFound);
      }
    }
  }
}
