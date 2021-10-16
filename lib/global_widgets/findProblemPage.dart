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
                  Navigator.pushNamed(context, CHAT_ROUTE);
                },
                child: Text('Chats')),
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
