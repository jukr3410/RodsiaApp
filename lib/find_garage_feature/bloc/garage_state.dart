part of 'garage_bloc.dart';

@immutable
abstract class GarageListState extends Equatable {
  const GarageListState();

  @override
  List<Object> get props => [];
}

class GarageListInitialState extends GarageListState {
  const GarageListInitialState();
}

class GarageListLoadingState extends GarageListState {
  final String message;

  const GarageListLoadingState({required this.message});
}

class GarageListSuccessState extends GarageListState {
  final List<Garage> garages;

  const GarageListSuccessState({required this.garages});
}

class GarageListEmptyState extends GarageListState {}

class GarageListErrorState extends GarageListState {
  final String error;

  const GarageListErrorState({required this.error});
}

class MapLoading extends GarageListState {}

class CurrentLocationSuccess extends GarageListState {
  final Position position;

  const CurrentLocationSuccess({required this.position});

  @override
  List<Object> get props => [position];

  @override
  String toString() => 'CurrentLocationSuccess {position: $position}';
}

class MapError extends GarageListState {}

class ShowGarageInfoSuccess extends GarageListState {
  final Garage garage;

  const ShowGarageInfoSuccess({required this.garage});

  @override
  String toString() => 'ShowGarageInfoSuccess {garage: ${garage.id}}';
}
