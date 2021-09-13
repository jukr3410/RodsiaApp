import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/splash.dart';
import 'package:rodsiaapp/home/appBar.dart';
import 'package:rodsiaapp/login_feature/widgets/login.dart';

class App extends StatelessWidget {
  var _duration = new Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Splash();

      ///when state is AuthenticationUninitialized
    }, listener: (context, state) {
      if (state is Unauthenticated) {
        Timer(_duration, () {
          Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
        });
      }

      if (state is Authenticated) {
        Timer(_duration, () {
          Navigator.pushReplacementNamed(context, MAIN_ROUTE);
        });
      }
    });
  }
}
