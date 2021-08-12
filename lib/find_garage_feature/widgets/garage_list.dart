import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';

abstract class GarageList extends StatefulWidget {
  @override
  _GarageListState createGarageState() => _GarageListState();
}

class _GarageListState extends State<GarageList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<GarageBloc, GarageState>(
          builder: (context, garageState) {
        if (garageState is GarageInitialState ||
            garageState is GarageLoadingState) {
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      }, listener: (context, garageState) {
        if (garageState is GarageErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(garageState.error)));
        }
      }),
    );
  }
}
