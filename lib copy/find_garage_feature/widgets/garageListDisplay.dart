import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageList.dart';

class DisplayGarageList extends StatelessWidget {
  late final GarageRepository garageRepository;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            GarageListBloc(garagerRepository: GarageRepository())
              ..add(GarageListFetchEvent()),
        child: Scaffold(
          body: GarageList(),
        ));
  }
}
