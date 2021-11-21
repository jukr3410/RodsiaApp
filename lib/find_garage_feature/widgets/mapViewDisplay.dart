import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/mapView.dart';

class DisplayMapView extends StatelessWidget {
  final FilterGarageModel? filter;
  DisplayMapView({required this.filter});
  String _serviceType = '';
  String _carType = '';

  late final GarageRepository garageRepository;
  @override
  Widget build(BuildContext context) {
    if (filter != null) {
      _serviceType = filter!.serviceType;
      _carType = filter!.carType;
    }
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            GarageListBloc(garagerRepository: GarageRepository()),
        child: MapView(
          filter:
              FilterGarageModel(serviceType: _serviceType, carType: _carType),
        ),
      ),
    );
  }
}
