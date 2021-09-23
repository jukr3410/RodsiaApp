import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

class FindProblemPage extends StatefulWidget {
  FindProblemPage({Key? key}) : super(key: key);

  @override
  _FindProblemPageState createState() => _FindProblemPageState();
}

class _FindProblemPageState extends State<FindProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, GARAGE_INFO_ROUTE);
              },
              child: Text('InfoGarageFomeSelect')),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SHOWINFO_BEFOREREQ_ROUTE);
              },
              child: Text('SelectCarAndRecapBeforeReq'))
        ],
      ),
    );
  }
}
