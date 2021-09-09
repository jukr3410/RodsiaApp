import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/invalidRoute.dart';
import 'package:rodsiaapp/profile_feature/widgets/profilePage.dart';
import 'package:rodsiaapp/request_service_feature/widgets/trackingRequestPage.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    print("Route: $settings");
    switch (settings.name) {
      case PROFILE_ROUTE:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      default:
        return MaterialPageRoute(builder: (_) => InvalidRouteScreen());
    }
  }
}
