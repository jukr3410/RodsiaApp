part of 'request_service_bloc.dart';

abstract class RequestServiceEvent extends Equatable {
  const RequestServiceEvent();

  @override
  List<Object> get props => [];
}

class CreateRequestService extends RequestServiceEvent {
  final RequestService requestService;

  const CreateRequestService(this.requestService);

  @override
  String toString() => 'GarageLoadInfo {garageId: $requestService}';
}
