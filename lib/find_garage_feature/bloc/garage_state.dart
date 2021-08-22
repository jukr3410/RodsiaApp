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

class GarageListErrorState extends GarageListState {
  final String error;

  const GarageListErrorState({required this.error});
}
