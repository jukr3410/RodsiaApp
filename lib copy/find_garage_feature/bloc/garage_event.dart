part of 'garage_bloc.dart';

@immutable
abstract class GarageListEvent {
  const GarageListEvent();
  @override
  List<Object> get props => [];
}

class GarageListFetchEvent extends GarageListEvent {
  const GarageListFetchEvent();
}
