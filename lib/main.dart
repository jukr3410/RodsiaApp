import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';

import 'constants.dart';

void main() {
  Bloc.observer = GarageBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RodSia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      // home: Scaffold(body: new AlertComfirmSuccess()),
      initialRoute: '/',
      routes: {
        BottomNavigrationBar.routeName: (context) => BottomNavigrationBar()
      },
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
