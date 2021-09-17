import 'package:flutter/material.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/request_service_feature/widgets/buttonRequestService.dart';
import 'package:rodsiaapp/request_service_feature/widgets/infoGarageFormSelect.dart';
import 'package:rodsiaapp/request_service_feature/widgets/selectServiceOfGarage.dart';

class SelectServicePage extends StatefulWidget {
  final Garage garage;
  SelectServicePage({Key? key, required this.garage}) : super(key: key);

  @override
  _SelectServicePageState createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        InfoGarageFormSelect(),
        SizedBox(
          height: 30,
        ),
        SelectServiceOfGarage(),
        SizedBox(
          height: 20,
        ),
        ButtonRequestService()
      ]),
    );
  }
}
