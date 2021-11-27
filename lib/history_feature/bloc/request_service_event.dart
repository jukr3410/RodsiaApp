part of 'request_service_bloc.dart';

abstract class RequestServiceEvent extends Equatable {
  const RequestServiceEvent();

  @override
  List<Object> get props => [];
}

class RequestServiceInitializeEvent extends RequestServiceEvent {}

class RequestServiceLoad extends RequestServiceEvent {}
class RequestServiceWithStatus extends RequestServiceEvent {
  final String status;
  RequestServiceWithStatus({required this.status});
}




