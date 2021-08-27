import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';

import '../../constants.dart';

class GarageList extends StatefulWidget {
  @override
  _GarageListState createState() => _GarageListState();

  // @override
  // _ListPageState createState() => _ListPageState();
}

class _GarageListState extends State<GarageList> {
  ScrollController scrollController = ScrollController();
  late GarageListBloc _garageListBloc =
      BlocProvider.of<GarageListBloc>(context);
  final scrollThreshold = 200;

  final List<Garage> _garages = [];

  //mock
  //late List garages;
  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(_onScroll);
  //   _garageListBloc = BlocProvider.of<GarageListBloc>(context);
  // }

  // void _onScroll() {
  //   final maxScroll = scrollController.position.maxScrollExtent;
  //   final currentScroll = scrollController.position.pixels;
  //   if (maxScroll - currentScroll <= scrollThreshold) {
  //     _garageListBloc.add(GarageListFetchEvent());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocConsumer<GarageListBloc, GarageListState>(
      listener: (context, garageState) {},
      builder: (context, garageState) {
        return _shimmer();
      },
    ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: BlocBuilder<GarageListBloc, GarageListState>(
  //         builder: (context, garageState) {
  //       if (garageState is GarageListInitialState) {
  //         return Center(
  //             child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
  //           child: _shimmer(),
  //         ));
  //       }
  //       if (garageState is GarageListErrorState) {
  //         return Center(
  //             child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
  //           child: Text(mError),
  //         ));
  //       }
  //       if (garageState is GarageListSuccessState) {
  //         if (garageState.garages.isEmpty) {
  //           return Center(
  //             child: Text(mNoGarages),
  //           );
  //         }
  //         return Scrollbar(
  //             child: ListView.builder(
  //                 scrollDirection: Axis.vertical,
  //                 controller: scrollController,
  //                 shrinkWrap: true,
  //                 physics: BouncingScrollPhysics(),
  //                 itemCount: garageState.hasReachedMax
  //                     ? garageState.garages.length
  //                     : garageState.garages.length + 1,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return index >= garageState.garages.length
  //                       ? _shimmer()
  //                       : _makeCardWidget(garageState.garages[index]);
  //                 }));
  //       }
  //       return CircularProgressIndicator();
  //     }),
  //   );
  // }

  _makeCardWidget(Garage garage) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              child: Image.network(
                'https://bestkru-thumbs.s3-ap-southeast-1.amazonaws.com/127399',
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    garage.name,
                    style: new TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: textColorBlack),
                  ),
                  Container(
                      margin: new EdgeInsets.only(top: 8),
                      child: Row(children: [
                        Text(
                          "distance: " + "12 km",
                          style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: textColorBlack),
                        ),
                        Text(
                          " | ",
                          style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                        Icon(
                          Icons.star,
                          color: primaryColor,
                          size: 20,
                        ),
                        Text(
                          " " + "3.9",
                          style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: textColorBlack),
                        ),
                      ])),
                  Container(
                    margin: new EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'close',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: textColorRed),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        //   child: Icon(Icons.data_usage),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  _shimmer() {
    return Shimmer.fromColors(
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
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
        highlightColor: Colors.grey.shade100);
  }
}

// class _ListPageState extends State<GarageList> {
//   late List garages;

//   @override
//   void initState() {
//     garages = getGarages();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _makeCardInfo(Garage garages) {
//       return Padding(
//           padding: EdgeInsets.all(16),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Image.network(
//               'https://bestkru-thumbs.s3-ap-southeast-1.amazonaws.com/127399',
//               width: 56,
//               height: 56,
//               fit: BoxFit.cover,
//             ),
//             Expanded(
//               child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Flutter Clutter", style: TextStyle(fontSize: 18)),
//                         Expanded(
//                             child: Text(
//                           "Well this is a pretty long title. I guess this will exceed the available space",
//                           overflow: TextOverflow.ellipsis,
//                         ))
//                       ])),
//             ),
//             Text("03.03.2020"),
//           ]));
//     }

//     _makeCard(Garage garage) {
//       return GestureDetector(
//         child: Card(
//           elevation: 3,
//           margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           color: cardColor,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.33,
//                 child: Image.network(
//                   'https://bestkru-thumbs.s3-ap-southeast-1.amazonaws.com/127399',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Flexible(
//                   child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       garage.name,
//                       style: new TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: textColorBlack),
//                     ),
//                     Container(
//                         margin: new EdgeInsets.only(top: 8),
//                         child: Row(children: [
//                           Text(
//                             "distance: " + "12 km",
//                             style: new TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.normal,
//                                 color: textColorBlack),
//                           ),
//                           Text(
//                             " | ",
//                             style: new TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black54),
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: primaryColor,
//                             size: 20,
//                           ),
//                           Text(
//                             " " + "3.9",
//                             style: new TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.normal,
//                                 color: textColorBlack),
//                           ),
//                         ])),
//                     Container(
//                       margin: new EdgeInsets.only(top: 4),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'close',
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.normal,
//                                 color: textColorRed),
//                           ),
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                           //   child: Icon(Icons.data_usage),
//                           // ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )),
//             ],
//           ),
//         ),
//         onTap: () {},
//       );
//     }

//     final makeBody = Container(
//       decoration: BoxDecoration(
//         color: Colors.white70,
//       ),
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: garages.length,
//         itemBuilder: (BuildContext context, int index) {
//           return _makeCard(garages[index]);
//         },
//       ),
//     );

//     return Scaffold(
//       backgroundColor: bgColor,
//       body: makeBody,
//     );
//   }
// }

// Mock
// List getGarages() {
//   return [
//     Garage(
//       name: "garage 1",
//       phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
//       email: "เปิด",
//       image: [],
//       logoImage: '',
//       openingHour: OpeningHour(
//           f: Day(open: '', close: ''),
//           m: Day(open: '', close: ''),
//           sa: Day(open: '', close: ''),
//           su: Day(open: '', close: ''),
//           th: Day(open: '', close: ''),
//           tu: Day(open: '', close: ''),
//           w: Day(open: '', close: '')),
//       address: Address(
//           addressDesc: "addressDesc",
//           geolocation: Geolocation(
//             lat: "",
//             long: '',
//           )),
//     ),
//     Garage(
//       name: "garage 1",
//       phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
//       email: "เปิด",
//       image: [],
//       logoImage: '',
//       openingHour: OpeningHour(
//           f: Day(open: '', close: ''),
//           m: Day(open: '', close: ''),
//           sa: Day(open: '', close: ''),
//           su: Day(open: '', close: ''),
//           th: Day(open: '', close: ''),
//           tu: Day(open: '', close: ''),
//           w: Day(open: '', close: '')),
//       address: Address(
//           addressDesc: "addressDesc",
//           geolocation: Geolocation(
//             lat: "",
//             long: '',
//           )),
//     ),
//     Garage(
//       name: "garage 1",
//       phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
//       email: "เปิด",
//       image: [],
//       logoImage: '',
//       openingHour: OpeningHour(
//           f: Day(open: '', close: ''),
//           m: Day(open: '', close: ''),
//           sa: Day(open: '', close: ''),
//           su: Day(open: '', close: ''),
//           th: Day(open: '', close: ''),
//           tu: Day(open: '', close: ''),
//           w: Day(open: '', close: '')),
//       address: Address(
//           addressDesc: "addressDesc",
//           geolocation: Geolocation(
//             lat: "",
//             long: '',
//           )),
//     ),
//     Garage(
//       name: "garage 1",
//       phone: "666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000",
//       email: "เปิด",
//       image: [],
//       logoImage: '',
//       openingHour: OpeningHour(
//           f: Day(open: '', close: ''),
//           m: Day(open: '', close: ''),
//           sa: Day(open: '', close: ''),
//           su: Day(open: '', close: ''),
//           th: Day(open: '', close: ''),
//           tu: Day(open: '', close: ''),
//           w: Day(open: '', close: '')),
//       address: Address(
//           addressDesc: "addressDesc",
//           geolocation: Geolocation(
//             lat: "",
//             long: '',
//           )),
//     )
//   ];
// }
