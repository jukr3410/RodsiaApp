import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/core/repository/service_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageList.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';

class DisplayGarageList extends StatelessWidget {
  late final GarageRepository garageRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            GarageListBloc(garagerRepository: GarageRepository())
              ..add(GarageListFetchEvent()),
      ),
      BlocProvider(
          create: (context) => GarageInfoBloc(
              garageRepository: GarageRepository(),
              serviceRepository: ServiceRepository())),
    ], child: GarageList()));
  }
}
