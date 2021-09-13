import 'package:flutter/material.dart';

class backPage extends StatefulWidget {
  backPage({Key? key}) : super(key: key);

  @override
  _backPageState createState() => _backPageState();
}

class _backPageState extends State<backPage> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context));
  }
}
