part of 'service_type_bloc.dart';

abstract class ServiceTypeState extends Equatable {
  const ServiceTypeState();

  @override
  List<Object> get props => [];
}

class ServiceTypeInitialState extends ServiceTypeState {}

class ServiceTypeLoadingState extends ServiceTypeState {
  final String message;

  const ServiceTypeLoadingState({required this.message});
}

class ServiceTypeSuccessState extends ServiceTypeState {
  final List<ServiceType> serviceType;

  const ServiceTypeSuccessState({required this.serviceType});
}

class ServiceTypeEmptyState extends ServiceTypeState {}

class ServiceTypeErrorState extends ServiceTypeState {
  final String error;

  const ServiceTypeErrorState({required this.error});
}
