part of 'garage_bloc.dart';

@immutable
abstract class GarageEvent {
  const GarageEvent();
}

class GarageFetchEvent extends GarageEvent {
  const GarageFetchEvent();
}
