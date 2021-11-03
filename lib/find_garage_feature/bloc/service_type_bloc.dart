import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/services_type_model.dart';
import 'package:rodsiaapp/core/repository/service_type_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'service_type_event.dart';
part 'service_type_state.dart';

class ServiceTypeBloc extends Bloc<ServiceTypeEvent, ServiceTypeState> {
  final ServiceTypeRepository serviceTypeRepository;
  bool isFetching = false;

  ServiceTypeBloc({required this.serviceTypeRepository})
      : super(ServiceTypeInitialState()) {}

  @override
  Stream<ServiceTypeState> mapEventToState(ServiceTypeEvent event) async* {
    if (event is ServiceTypeFetchEvent) {
      try {
        yield ServiceTypeLoadingState(message: mLoading);
        final serviceType = await serviceTypeRepository.getServiceTypes();
        if (serviceType.isNotEmpty) {
          yield ServiceTypeSuccessState(serviceType: serviceType);
        }
      } catch (e) {
        logger.e(e);
        yield ServiceTypeErrorState(error: mError);
      }
    }
  }
}
