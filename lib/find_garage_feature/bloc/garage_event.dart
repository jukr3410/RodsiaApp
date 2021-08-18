part of 'garage_bloc.dart';

@immutable
abstract class GarageEvent {
  const GarageEvent();
}

class GarageListFetchEvent extends GarageEvent {
  const GarageListFetchEvent();
}
