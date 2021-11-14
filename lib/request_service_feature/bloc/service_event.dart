part of 'service_bloc.dart';

@immutable
abstract class ServiceEvent {
  const ServiceEvent();
}

class ServiceFetchEvent extends ServiceEvent {
  final String serviceId;
  const ServiceFetchEvent({required this.serviceId});
}
