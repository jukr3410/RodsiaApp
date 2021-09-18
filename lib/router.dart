import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/core/repository/service_repository.dart';
import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';
import 'package:rodsiaapp/global_widgets/invalidRoute.dart';
import 'package:rodsiaapp/home/app.dart';
import 'package:rodsiaapp/home/appBar.dart';
import 'package:rodsiaapp/home/bloc/home_bloc.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectMoreChoice.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectCarTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectFuelTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/showInfoNewCar.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editCarModel.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editSelectCarTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editSelectMoreChoicePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editShowInfoNewCar.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/infoGarageFormSelect.dart';
import 'core/models/car_model.dart';
import 'core/repository/user_repository.dart';
import 'login_feature/bloc/login_bloc.dart';
import 'login_feature/widgets/login.dart';
import 'register_user_feature/bloc/register_bloc.dart';
import 'register_user_feature/widgets/addInfo.dart';
import 'register_user_feature/widgets/addNumber.dart';
import 'register_user_feature/widgets/otp.dart';
import 'request_service_feature/widgets/selectServicePage.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    print("Route: $settings");
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    AuthenticationBloc(userRepository: UserRepository())
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
                  create: (BuildContext context) => LoginBloc(
                      userRepository: UserRepository(),
                      authenticationBloc:
                          AuthenticationBloc(userRepository: UserRepository())),
                  child: LoginScreen(),
                ));

      case ADD_NUMBER_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: AddNumber()));

      case OTP_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: Otp()));

      case REGISTER_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: AddInfo()));

      case HOMEPAGE_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    AuthenticationBloc(userRepository: UserRepository()),
                child: BottomNavigrationBar(user: user)));

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

      case EDITCAR_CARTYPE_ROUTE:
        EditCarNoNewCar car = settings.arguments as EditCarNoNewCar;
        return MaterialPageRoute(
            builder: (_) => EditSelectCarTypePage(
                  car: car,
                ));

      case EDITCAR_MORECHOICE_ROUTE:
        EditCarAndIndex editCar = settings.arguments as EditCarAndIndex;
        return MaterialPageRoute(
            builder: (_) => EditSelectMoreChoice(
                  editCar: editCar,
                ));

      case EDITCAR_SHOWINFO_ROUTE:
        EditCarAndIndex editCar = settings.arguments as EditCarAndIndex;
        return MaterialPageRoute(
            builder: (_) => EditShowInfoNewCar(
                  car: editCar,
                ));

      case GARAGE_INFO_ROUTE:
        String garageId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => GarageInfoBloc(
                    garageRepository: GarageRepository(),
                    serviceRepository: ServiceRepository()),
                child: SelectServicePage(
                  garageId: garageId,
                )));

      default:
        return MaterialPageRoute(builder: (_) => InvalidRouteScreen());
    }
  }
}
