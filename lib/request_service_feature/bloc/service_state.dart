part of 'service_bloc.dart';

@immutable
abstract class ServiceState {
  const ServiceState();
}

class ServiceInitialState extends ServiceState {
  const ServiceInitialState();
}

class ServiceLoadingState extends ServiceState {
  final String message;

  const ServiceLoadingState({required this.message});
}

class ServiceSuccessState extends ServiceState {
  final Service service;

  const ServiceSuccessState({required this.service});

  @override
  List<Object> get props => [service];
}

class ServiceErrorState extends ServiceState {
  final String error;

  const ServiceErrorState({required this.error});
}
