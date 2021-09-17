import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/buttonRequestService.dart';
import 'package:rodsiaapp/request_service_feature/widgets/infoGarageFormSelect.dart';
import 'package:rodsiaapp/request_service_feature/widgets/selectServiceOfGarage.dart';

class SelectServicePage extends StatefulWidget {
  final String garageId;
  SelectServicePage({Key? key, required this.garageId}) : super(key: key);

  @override
  _SelectServicePageState createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  late GarageInfoBloc _garageInfoBloc;

  @override
  void initState() {
    _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad(widget.garageId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GarageInfoBloc, GarageInfoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GarageInfoInitial || state is GarageInfoLoading) {
            return Center(
              child: Text(mLoading),
            );
          } else if (state is GarageLoadSuccess) {
            return Column(children: [
              InfoGarageFormSelect(garage: state.garage),
              SizedBox(
                height: 30,
              ),
              SelectServiceOfGarage(
                services: state.services,
              ),
              SizedBox(
                height: 20,
              ),
              ButtonRequestService()
            ]);
          }
          return Center(
            child: Text(mLoading),
          );
        },
      ),
    );
  }
}
