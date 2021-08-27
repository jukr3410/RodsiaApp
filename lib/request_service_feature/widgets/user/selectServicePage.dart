import 'package:flutter/material.dart';
import 'package:rodsiaapp/request_service_feature/widgets/user/buttonRequestService.dart';
import 'package:rodsiaapp/request_service_feature/widgets/user/infoGarageFormSelect.dart';
import 'package:rodsiaapp/request_service_feature/widgets/user/selectServiceOfGarage.dart';

class SelectServicePage extends StatefulWidget {
  SelectServicePage({Key? key}) : super(key: key);

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
