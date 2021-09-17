import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/selectServicePage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:getwidget/getwidget.dart';

import '../../constants.dart';

class GarageList extends StatefulWidget {
  @override
  _GarageListState createState() => _GarageListState();
}

class _GarageListState extends State<GarageList> {
  ScrollController scrollController = ScrollController();
  late GarageListBloc _garageListBloc;

  final List<Garage> _garages = [];

  @override
  void initState() {
    _garageListBloc = BlocProvider.of<GarageListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<GarageListBloc, GarageListState>(
        listener: (context, garageState) {
          if (garageState is GarageListLoadingState) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(garageState.message)));

          } else if (garageState is GarageListSuccessState &&
              garageState.garages.isEmpty) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text('No more garages')));
          } else if (garageState is GarageListErrorState) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(garageState.error)));

            // showTopSnackBar(
            //   context,
            //   CustomSnackBar.error(
            //     message: mError,
            //   ),
            // );
            _garageListBloc.isFetching = false;
          }
          return;
        },
        builder: (context, garageState) {
          if (garageState is GarageListInitialState ||
              garageState is GarageListLoadingState && _garages.isEmpty) {
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: _shimmer(),
            ));
          } else if (garageState is GarageListSuccessState) {
            _garages.addAll(garageState.garages);
            _garageListBloc.isFetching = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (garageState is GarageListErrorState && _garages.isEmpty) {
            return Center(
                child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    _garageListBloc
                      ..isFetching = true
                      ..add(GarageListFetchEvent());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(garageState.error, textAlign: TextAlign.center),
              ],
            ));
          }
          return ListView.builder(
            controller: scrollController
              ..addListener(() {
                if (scrollController.offset ==
                        scrollController.position.maxScrollExtent &&
                    !_garageListBloc.isFetching) {
                  _garageListBloc
                    ..isFetching = true
                    ..add(GarageListFetchEvent());
                }
              }),
            itemBuilder: (context, index) =>
                _makeCardWidget(_garages[index], index),
            itemCount: _garages.length,
          );
        },
      ),
    );
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

  _makeCardWidget(Garage garage, int index) {
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
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectServicePage(garage: _garages[index])));
      },
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
                  width: 100.0,
                  height: 100.0,
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
