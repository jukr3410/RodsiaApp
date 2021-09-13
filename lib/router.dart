import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/invalidRoute.dart';
import 'package:rodsiaapp/home/app.dart';
import 'package:rodsiaapp/home/appBar.dart';
import 'package:rodsiaapp/home/bloc/home_bloc.dart';
import 'package:rodsiaapp/login_feature/bloc/login_bloc.dart';
import 'package:rodsiaapp/login_feature/widgets/login.dart';
import 'package:rodsiaapp/profile_feature/widgets/profilePage.dart';
import 'package:rodsiaapp/register_garage_feature/bloc/register_bloc.dart';
import 'package:rodsiaapp/register_garage_feature/widgets/registerScreen.dart';
import 'package:rodsiaapp/request_service_feature/widgets/trackingRequestPage.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    print("Route: $settings");
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => App());

      case MAIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => HomeBloc(),
                child: CustomAppBar()));

      case LOGIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => LoginBloc(),
                  child: LoginScreen(),
                ));

      case REGISTER_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: RegisterScreen()));

      case PROFILE_ROUTE:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      default:
        return MaterialPageRoute(builder: (_) => InvalidRouteScreen());
    }
  }
}
