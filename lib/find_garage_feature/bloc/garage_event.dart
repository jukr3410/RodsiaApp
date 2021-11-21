part of 'garage_bloc.dart';

@immutable
abstract class GarageListEvent {
  const GarageListEvent();
  @override
  List<Object> get props => [];
}

class GarageListFetchEvent extends GarageListEvent {
  final FilterGarageModel filter;
  const GarageListFetchEvent({required this.filter});
}

class GarageSearchListFetchEvent extends GarageListEvent {
  final String nameGarage;
  const GarageSearchListFetchEvent({required this.nameGarage});
}

class GetCurrentLocation extends GarageListEvent {}

class ShowGarageInfo extends GarageListEvent {
  final Garage garage;

  const ShowGarageInfo({required this.garage});

  @override
  String toString() => 'ShowGarageInfo {garage: $garage}';
}
