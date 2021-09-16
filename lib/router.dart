import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';
import 'package:rodsiaapp/global_widgets/invalidRoute.dart';
import 'package:rodsiaapp/home/app.dart';
import 'package:rodsiaapp/home/appBar.dart';
import 'package:rodsiaapp/home/bloc/home_bloc.dart';
import 'package:rodsiaapp/login_feature%20copy/bloc/login_bloc.dart';
import 'package:rodsiaapp/login_feature%20copy/widgets/login.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectMoreChoice.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectCarTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectFuelTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/showInfoNewCar.dart';
import 'package:rodsiaapp/register_garage_feature/bloc/register_bloc.dart';
import 'core/models/car_model.dart';
import 'register_garage_feature/widgets/addInfo.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    print("Route: $settings");
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    AuthenticationBloc(garageRepository: GarageRepository())
                      ..add(AppStarted()),
                child: App()));

      case MAIN_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => HomeBloc(),
                child: CustomAppBar(
                  user: user,
                )));

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
                child: AddInfo()));

      case HOMEPAGE_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BottomNavigrationBar(user: user));

      case PROFILE_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => ProfilePage(
                  user: user,
                ));

      case ADDCAR_CARTYPE_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => SelectCarTypePage(
                  user: user,
                ));

      case ADDCAR_MORECHOICE_ROUTE:
        Car car = settings.arguments as Car;
        return MaterialPageRoute(
            builder: (_) => SelectMoreChoice(
                  car: car,
                ));

      case ADDCAR_SHOWINFO_NEWCAR_ROUTE:
        Car car = settings.arguments as Car;
        return MaterialPageRoute(builder: (_) => ShowInfoNewCar(car: car));

      case EDITCAR_ROUTE:
        Car car = settings.arguments as Car;
        return MaterialPageRoute(builder: (_) => ShowInfoNewCar(car: car));

      default:
        return MaterialPageRoute(builder: (_) => InvalidRouteScreen());
    }
  }
}
