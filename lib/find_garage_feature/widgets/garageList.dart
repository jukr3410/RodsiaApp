import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';

import '../../constants.dart';

class GarageList extends StatefulWidget {
  // @override
  // _GarageListState createState() => _GarageListState();

  @override
  _ListPageState createState() => _ListPageState();
}

class _GarageListState extends State<GarageList> {
  ScrollController scrollController = ScrollController();
  late GarageListBloc _garageListBloc;
  final scrollThreshold = 200;

  //mock
  late List garages;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    _garageListBloc = BlocProvider.of<GarageListBloc>(context);
  }

  void _onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= scrollThreshold) {
      _garageListBloc.add(GarageListFetchEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<GarageListBloc, GarageListState>(
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

class _ListPageState extends State<GarageList> {
  late List garages;

  @override
  void initState() {
    garages = getGarages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Garage garage) => ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 130,
              minHeight: 80,
            ),
            child: ClipRRect(
              borderRadius: borderRadiusLow,
              child: Image.network(
                'https://bestkru-thumbs.s3-ap-southeast-1.amazonaws.com/127399',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // leading: Container(
          //   height: 80.0,
          //   width: 130.0,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       fit: BoxFit.cover,
          //       image: NetworkImage(
          //           'https://lh3.googleusercontent.com/iCWjvZ8RwFvdC47khW4QxeHvRpBACa242cumpyKf2fshsCaYfXTRe2_DpLUP97evWiIHD7Ku6WjbpDkd=w1080-h608-p-no-v0'),
          //     ),
          //   ),

          //   //padding: EdgeInsets.only(right: 8.0),
          // ),
          title: Text(
            garage.name,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 8.0),
                  child: Text(garage.phone,
                      style: TextStyle(color: Colors.black))),
              Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 4.0),
                  child: Text(garage.email,
                      style: TextStyle(color: Colors.green))),
            ],
          ),
          // trailing:
          //     Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
          // onTap: () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => DetailPage(garage: garage)));
          // },
        );

    Card makeCard(Garage garage) => Card(
          elevation: 4.0,
          margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: makeListTile(garage),
          ),
        );

    final makeBody = Container(
      decoration: BoxDecoration(
        color: Colors.white70,
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: garages.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(garages[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white70,
      body: makeBody,
    );
  }
}

// Mock
List getGarages() {
  return [
    // Garage(
    //     name: "garage 1",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 2",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 3",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 4",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 1",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 2",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 3",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 4",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 1",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 2",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 3",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
    // Garage(
    //     name: "garage 4",
    //     phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
    //     email: "เปิด"),
  ];
}
