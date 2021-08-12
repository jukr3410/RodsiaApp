part of 'garage_bloc.dart';

@immutable
abstract class GarageState {
  const GarageState();
}

class GarageInitialState extends GarageState {
  const GarageInitialState();
}

class GarageLoadingState extends GarageState {
  final String message;

  const GarageLoadingState({required this.message});
}

class GarageSuccessState extends GarageState {
  final List<Garage> garages;

  const GarageSuccessState({required this.garages});
}

class GarageErrorState extends GarageState {
  final String error;

  const GarageErrorState({required this.error});
}
