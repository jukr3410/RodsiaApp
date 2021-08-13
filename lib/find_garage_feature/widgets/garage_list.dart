import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';

class GarageList extends StatefulWidget {
  @override
  _GarageListState createState() => _GarageListState();
}

class _GarageListState extends State<GarageList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<GarageBloc, GarageState>(
          builder: (context, garageState) {
        if (garageState is GarageListInitialState ||
            garageState is GarageListLoadingState) {
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      }, listener: (context, garageState) {
        if (garageState is GarageListErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(garageState.error)));
        }
      }),
    );
  }
}
