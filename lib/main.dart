import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rodsiaapp/global_widgets/alertGiveScore.dart';
import 'package:rodsiaapp/global_widgets/alertSelectCar.dart';

import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectCarTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiaapp/request_service_feature/widgets/requestDetailAndGiveStarPage.dart';
import 'package:rodsiaapp/request_service_feature/widgets/trackingRequestPage.dart';
import 'package:rodsiaapp/router.dart';

import 'constants.dart';

void main() {
  Bloc.observer = GarageBlocObserver();
  runApp(RodSiaApp(router: AppRouter()));
}

class RodSiaApp extends StatelessWidget {
  final AppRouter router;

  const RodSiaApp({Key? key, required this.router}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RodSia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
      ),
      home: DetailAndGiveStarPage(),
      // onGenerateRoute: router.generateRoute,
      // initialRoute: '/',
      // routes: {
      //   BottomNavigrationBar.routeName: (context) => BottomNavigrationBar()
      // },
    );
  }
}

class GarageBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

var logger = Logger(
  printer: PrettyPrinter(),
);
