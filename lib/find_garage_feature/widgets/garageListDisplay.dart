import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/core/repository/service_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageList.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/mapViewDisplay.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';

class DisplayGarageList extends StatelessWidget {
  final FilterGarageModel? filter;
  DisplayGarageList({required this.filter});
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
              GarageListBloc(garagerRepository: GarageRepository())
                ..add(GarageListFetchEvent(
                    filter: FilterGarageModel(
                        serviceType: _serviceType, carType: _carType))),
          child: GarageList(
            filter:
                FilterGarageModel(serviceType: _serviceType, carType: _carType),
          )),
    );
  }
}
