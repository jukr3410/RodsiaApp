part of 'service_type_bloc.dart';

abstract class ServiceTypeEvent extends Equatable {
  const ServiceTypeEvent();

  @override
  List<Object> get props => [];
}

class ServiceTypeFetchEvent extends ServiceTypeEvent {
  const ServiceTypeFetchEvent();
}

class ShowServiceTypeInfo extends ServiceTypeEvent {
  final ServiceType serviceType;
  const ShowServiceTypeInfo({required this.serviceType});

  @override
  String toString() => 'ShowServiceType {serviceType: $serviceType}';
}
