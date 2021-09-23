import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: setAppBar(),
      body: BlocConsumer<GarageInfoBloc, GarageInfoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GarageLoadSuccess) {
            return Column(children: [
              Flexible(
                flex: 1,
                child: InfoGarageFormSelect(garage: state.garage),
              ),
              SizedBox(
                height: 30,
              ),
              Flexible(
                flex: 1,
                child: SelectServiceOfGarage(
                  services: state.services,
                ),
              )
            ]);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      // title: Text(
      //   tAddService,
      //   style: TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
      // ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColorBlack,
        ),
        onPressed: () {
          navigateToGarageList();
        },
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.add, color: iconColorBlack),
        //   onPressed: () {},
        //   iconSize: 30.0,
        // ),
      ],
    );
  }

  navigateToGarageList() {
    Navigator.pop(context);
  }
}
