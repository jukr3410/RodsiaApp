part of 'garage_info_bloc.dart';

abstract class GarageInfoState extends Equatable {
  const GarageInfoState();

  @override
  List<Object> get props => [];
}

class GarageInfoInitial extends GarageInfoState {}

class GarageInfoLoading extends GarageInfoState {}

class GarageInfoError extends GarageInfoState {}

class GarageLoadSuccess extends GarageInfoState {
  final Garage garage;
  // final List<Service> services;

  const GarageLoadSuccess(
    this.garage,
    // this.services
  );

  @override
  List<Object> get props => [
        garage,
        // services
      ];

  @override
  String toString() => 'GarageLoadSuccess {garage: ${garage.id}, service: }';
}
