part of 'request_service_bloc.dart';

abstract class RequestServiceEvent extends Equatable {
  const RequestServiceEvent();

  @override
  List<Object> get props => [];
}

class CreateRequestService extends RequestServiceEvent {
  final RequestServiceAdd requestServiceAdd;

  const CreateRequestService({required this.requestServiceAdd});

  @override
  String toString() =>
      'CreateRequestService {requestService: $requestServiceAdd}';
}

class CancelRequestService extends RequestServiceEvent {
  final String requestServiceId;

  const CancelRequestService({required this.requestServiceId});

  @override
  String toString() =>
      'CancelRequestService {requestService: $requestServiceId}';
}

class LoadRequestService extends RequestServiceEvent {
  final String requestServiceId;

  const LoadRequestService({required this.requestServiceId});

  @override
  String toString() => 'LoadRequestService {requestService: $requestServiceId}';
}

class LoadRequestServiceByUserId extends RequestServiceEvent {
  final String userId;

  const LoadRequestServiceByUserId({required this.userId});

  @override
  String toString() => 'LoadRequestService {requestService: $userId}';
}

class TrackingRequestService extends RequestServiceEvent {
  final String requestServiceId;

  const TrackingRequestService({required this.requestServiceId});

  @override
  String toString() => 'LoadRequestService {requestService: $requestServiceId}';
}
