import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';

import '../../constants.dart';

class GarageList extends StatefulWidget {
  @override
  _GarageListState createState() => _GarageListState();

  //@override
  //_ListPageState createState() => _ListPageState();
}

class _GarageListState extends State<GarageList> {
  ScrollController scrollController = ScrollController();
  late GarageListBloc _garageListBloc;
  final scrollThreshold = 200;

  //mock
  //late List garages;
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
      child: BlocBuilder<GarageListBloc, GarageListState>(
          builder: (context, garageState) {
        if (garageState is GarageListInitialState) {
          return Center(child: CircularProgressIndicator());
        }
        if (garageState is GarageListErrorState) {
          return Center(
            child: Text(mError),
          );
        }
        if (garageState is GarageListSuccessState) {
          if (garageState.garages.isEmpty) {
            return Center(
              child: Text(mNoGarages),
            );
          }
          return Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: garageState.hasReachedMax
                      ? garageState.garages.length
                      : garageState.garages.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= garageState.garages.length
                        ? Shimmer.fromColors(
                            child: ListView.builder(
                              itemBuilder: (_, __) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 48.0,
                                      height: 48.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.0),
                                          ),
                                          Container(
                                            width: 40.0,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              itemCount: 6,
                            ),
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100)
                        : _makeCardWidget(garageState.garages[index]);
                  }));
        }
        return CircularProgressIndicator();
      }),
    );
  }

  _makeCardWidget(Garage garage) {
    return Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(color: cardColor),
        child: _makeListTile(garage),
      ),
    );
  }

  _makeListTile(Garage garage) {
    return ListTile(
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
              child: Text(garage.phone, style: TextStyle(color: Colors.black))),
          Padding(
              padding: EdgeInsets.only(left: 0.0, top: 4.0),
              child: Text(garage.email, style: TextStyle(color: Colors.green))),
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

    _makeCard(Garage garages) {
      return Card(
          margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: Container(
              decoration: BoxDecoration(color: cardColor),
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://bestkru-thumbs.s3-ap-southeast-1.amazonaws.com/127399',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Flutter Clutter",
                                        style: TextStyle(fontSize: 18)),
                                    Expanded(
                                        child: Text(
                                      "Well this is a pretty long title. I guess this will exceed the available space",
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ])),
                        ),
                        Text("03.03.2020"),
                      ]))));
    }

    Card makeCard(Garage garage) => Card(
          elevation: 4.0,
          margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: Container(
            decoration: BoxDecoration(color: cardColor),
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
          return _makeCard(garages[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: makeBody,
    );
  }
}

// Mock
List getGarages() {
  return [
    Garage(
      name: "garage 1",
      phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
      email: "เปิด",
      image: [],
      logoImage: '',
      openingHour: OpeningHour(
          f: Day(open: '', close: ''),
          m: Day(open: '', close: ''),
          sa: Day(open: '', close: ''),
          su: Day(open: '', close: ''),
          th: Day(open: '', close: ''),
          tu: Day(open: '', close: ''),
          w: Day(open: '', close: '')),
      address: Address(
          addressDesc: "addressDesc",
          geolocation: Geolocation(
            lat: "",
            long: '',
          )),
    ),
    Garage(
      name: "garage 1",
      phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
      email: "เปิด",
      image: [],
      logoImage: '',
      openingHour: OpeningHour(
          f: Day(open: '', close: ''),
          m: Day(open: '', close: ''),
          sa: Day(open: '', close: ''),
          su: Day(open: '', close: ''),
          th: Day(open: '', close: ''),
          tu: Day(open: '', close: ''),
          w: Day(open: '', close: '')),
      address: Address(
          addressDesc: "addressDesc",
          geolocation: Geolocation(
            lat: "",
            long: '',
          )),
    ),
    Garage(
      name: "garage 1",
      phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
      email: "เปิด",
      image: [],
      logoImage: '',
      openingHour: OpeningHour(
          f: Day(open: '', close: ''),
          m: Day(open: '', close: ''),
          sa: Day(open: '', close: ''),
          su: Day(open: '', close: ''),
          th: Day(open: '', close: ''),
          tu: Day(open: '', close: ''),
          w: Day(open: '', close: '')),
      address: Address(
          addressDesc: "addressDesc",
          geolocation: Geolocation(
            lat: "",
            long: '',
          )),
    ),
    Garage(
      name: "garage 1",
      phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
      email: "เปิด",
      image: [],
      logoImage: '',
      openingHour: OpeningHour(
          f: Day(open: '', close: ''),
          m: Day(open: '', close: ''),
          sa: Day(open: '', close: ''),
          su: Day(open: '', close: ''),
          th: Day(open: '', close: ''),
          tu: Day(open: '', close: ''),
          w: Day(open: '', close: '')),
      address: Address(
          addressDesc: "addressDesc",
          geolocation: Geolocation(
            lat: "",
            long: '',
          )),
    )
  ];
}
