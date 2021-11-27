part of 'request_service_bloc.dart';

abstract class RequestServiceState extends Equatable {
  const RequestServiceState();

  @override
  List<Object> get props => [];
}

class RequestServiceInitial extends RequestServiceState {}

class RequestServiceLoading extends RequestServiceState {}

class RequestServiceLoadSuccess extends RequestServiceState {
  final RequestService requestService;
  final DistanceMatrix? distanceMatrix;

  const RequestServiceLoadSuccess(
      {required this.requestService, this.distanceMatrix});

  @override
  List<Object> get props => [requestService];

  @override
  String toString() =>
      'RequestServiceLoadSuccess { requestService: ${requestService} }';
}

class RequestServiceError extends RequestServiceState {}

class CreatingRequestService extends RequestServiceState {}

class CreatedRequestService extends RequestServiceState {
  final RequestService requestService;

  const CreatedRequestService({required this.requestService});

  @override
  List<Object> get props => [requestService];

  @override
  String toString() =>
      'CreatedRequestService { requestServiceId: $requestService }';
}

class CanceledRequestService extends RequestServiceState {}

class CreateRequestServiceError extends RequestServiceState {}

class RequestServiceWaiting extends RequestServiceState {}

class RequestServiceGarageConfirmed extends RequestServiceState {
  final RequestService requestService;
  RequestServiceGarageConfirmed({required this.requestService});
}

class RequestServiceGarageDeny extends RequestServiceState {}

class RequestServiceInService extends RequestServiceState {}

class RequestServiceComleted extends RequestServiceState {}

class CurrentLocationAndAddressSuccess extends RequestServiceState {
  final Position position;
  final String? address;

  const CurrentLocationAndAddressSuccess(
      {required this.position, this.address});

  @override
  List<Object> get props => [position];

  @override
  String toString() => 'CurrentLocationSuccess {position: $position}';
}
