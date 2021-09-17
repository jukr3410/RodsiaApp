part of 'garage_info_bloc.dart';

abstract class GarageInfoEvent extends Equatable {
  const GarageInfoEvent();

  @override
  List<Object> get props => [];
}

class GarageInfoLoad extends GarageInfoEvent {
  final String garageId;

  const GarageInfoLoad(this.garageId);

  @override
  String toString() => 'GarageLoadInfo {garageId: $garageId}';
}
