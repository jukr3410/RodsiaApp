part of 'garage_bloc.dart';

@immutable
abstract class GarageState {
  const GarageState();
}

class GarageListInitialState extends GarageState {
  const GarageListInitialState();
}

class GarageListLoadingState extends GarageState {
  final String message;

  const GarageListLoadingState({required this.message});
}

class GarageListSuccessState extends GarageState {
  final List<Garage> garages;
  final bool hasReachedMax;

  const GarageListSuccessState(
      {required this.garages, required this.hasReachedMax});
  GarageListSuccessState copyWith(
      {required List<Garage> garages, required bool hasReachedMax}) {
    return GarageListSuccessState(
        garages: garages, hasReachedMax: hasReachedMax);
  }

  @override
  List<Object> get props => [garages, hasReachedMax];
}

class GarageListErrorState extends GarageState {
  final String error;

  const GarageListErrorState({required this.error});
}
