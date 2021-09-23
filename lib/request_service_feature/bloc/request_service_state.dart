part of 'request_service_bloc.dart';

abstract class RequestServiceState extends Equatable {
  const RequestServiceState();

  @override
  List<Object> get props => [];
}

class RequestServiceInitial extends RequestServiceState {}

class RequestServiceLoading extends RequestServiceState {}

class RequestServiceLoadSuccess extends RequestServiceState {
  final RequestServiceAdd requestServiceAdd;

  const RequestServiceLoadSuccess({required this.requestServiceAdd});

  @override
  List<Object> get props => [requestServiceAdd];

  @override
  String toString() =>
      'RequestServiceLoadSuccess { requestService: ${requestServiceAdd} }';
}

class RequestServiceError extends RequestServiceState {}

class CreatingRequestService extends RequestServiceState {}

class CreatedRequestService extends RequestServiceState {
  final String requestServiceId;

  const CreatedRequestService({required this.requestServiceId});

  @override
  List<Object> get props => [requestServiceId];

  @override
  String toString() =>
      'CreatedRequestService { requestServiceId: $requestServiceId }';
}

class CreateRequestServiceError extends RequestServiceState {}

class RequestServiceWaiting extends RequestServiceState {}

class RequestServiceGarageConfirmed extends RequestServiceState {}

class RequestServiceInService extends RequestServiceState {}

class RequestServiceComleted extends RequestServiceState {}
