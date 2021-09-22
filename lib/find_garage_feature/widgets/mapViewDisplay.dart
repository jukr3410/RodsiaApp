import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/mapView.dart';

class DisplayMapView extends StatelessWidget {
  late final GarageRepository garageRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            GarageListBloc(garagerRepository: GarageRepository()),
        child: MapView(),
      ),
    );
  }
}