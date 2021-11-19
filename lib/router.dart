import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiaapp/communication_feature/widgets/chat_ui.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/core/repository/service_repository.dart';
import 'package:rodsiaapp/core/repository/service_type_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/service_type_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/filterGarage.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageFormSearchPage.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageList.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/mapView.dart';
import 'package:rodsiaapp/find_problem_feature/widgets/findProblemFormSelected.dart';
import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';
import 'package:rodsiaapp/global_widgets/invalidRoute.dart';
import 'package:rodsiaapp/global_widgets/supportCenterPage.dart';
import 'package:rodsiaapp/history_feature/bloc/request_service_bloc.dart'
    as historyBloc;
import 'package:rodsiaapp/history_feature/widgets/historyInfoPage.dart';
import 'package:rodsiaapp/history_feature/widgets/listHistory.dart';
import 'package:rodsiaapp/home/app.dart';
import 'package:rodsiaapp/home/appBar.dart';
import 'package:rodsiaapp/home/bloc/home_bloc.dart';
import 'package:rodsiaapp/notify_feature/widgets/notifyFormSelectPage.dart';
import 'package:rodsiaapp/notify_feature/widgets/notifyPage.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectMoreChoice.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectCarTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/showInfoNewCar.dart';
import 'package:rodsiaapp/profile_feature/widgets/editProfile.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editCarModel.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editSelectCarTypePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editSelectMoreChoicePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editShowInfoNewCar.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/bloc/service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/ConfirmRequestService.dart';
import 'package:rodsiaapp/request_service_feature/widgets/infoGarageFormSelect.dart';
import 'package:rodsiaapp/request_service_feature/widgets/requestDetailAndGiveStarPage.dart';
import 'package:rodsiaapp/request_service_feature/widgets/selectCarAndRecapBeforeReq.dart';
import 'package:rodsiaapp/request_service_feature/widgets/trackingRequestPage.dart';
import 'package:rodsiaapp/request_service_feature/widgets/waitForGaragePage.dart';
import 'core/models/car_model.dart';
import 'core/models/request_service_model.dart';
import 'core/models/service_model.dart';
import 'core/repository/request_service_repository.dart';
import 'core/repository/user_repository.dart';
import 'find_garage_feature/bloc/garage_bloc.dart';
import 'login_feature/bloc/login_bloc.dart';
import 'login_feature/widgets/login.dart';
import 'profile_feature/bloc/profile_bloc.dart';
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
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (BuildContext context) =>
                          AuthenticationBloc(userRepository: UserRepository())),
                  BlocProvider(
                    create: (BuildContext context) => HomeBloc(),
                  ),
                  BlocProvider(
                    create: (BuildContext context) =>
                        ProfileBloc(userRepository: UserRepository()),
                  ),
                  BlocProvider(
                    create: (BuildContext context) => ServiceTypeBloc(
                        serviceTypeRepository: ServiceTypeRepository()),
                  ),
                  BlocProvider(
                      create: (BuildContext context) =>
                          historyBloc.RequestServiceBloc(
                              requestServiceRepository:
                                  RequestServiceRepository())),
                ], child: CustomAppBar()));

      case LOGIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<LoginBloc>(
                        create: (BuildContext context) => LoginBloc(
                            userRepository: UserRepository(),
                            authenticationBloc: AuthenticationBloc(
                                userRepository: UserRepository()))),
                  ],
                  child: LoginScreen(),
                ));

      case ADD_NUMBER_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    RegisterBloc(userRepository: UserRepository()),
                child: AddNumber()));

      case OTP_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    RegisterBloc(userRepository: UserRepository()),
                child: Otp(
                  user: user,
                )));

      case REGISTER_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    RegisterBloc(userRepository: UserRepository()),
                child: AddInfo(
                  user: user,
                )));

      case HOMEPAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (BuildContext context) =>
                          AuthenticationBloc(userRepository: UserRepository())),
                  BlocProvider(
                    create: (BuildContext context) => HomeBloc(),
                  ),
                  BlocProvider(
                    create: (BuildContext context) =>
                        ProfileBloc(userRepository: UserRepository()),
                  ),
                ], child: BottomNavigrationBar()));

      case PROFILE_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ProfileBloc(userRepository: UserRepository()),
                child: ProfilePage(
                  user: user,
                )));

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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ProfileBloc(userRepository: UserRepository()),
                child: ShowInfoNewCar(car: car)));

      case EDITCAR_CARTYPE_ROUTE:
        EditCarNoNewCar car = settings.arguments as EditCarNoNewCar;
        return MaterialPageRoute(
            builder: (_) => EditSelectCarTypePage(
                  car: car,
                ));

      case EDITCAR_MORECHOICE_ROUTE:
        EditCarNoNewCar car = settings.arguments as EditCarNoNewCar;
        return MaterialPageRoute(
            builder: (_) => EditSelectMoreChoice(
                  car: car,
                ));

      case EDITCAR_SHOWINFO_ROUTE:
        EditCarNoNewCar car = settings.arguments as EditCarNoNewCar;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ProfileBloc(userRepository: UserRepository()),
                child: EditShowInfoNewCar(
                  car: car,
                )));

      case GARAGE_INFO_ROUTE:
        // Map args = settings.arguments as Map;
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => GarageInfoBloc(
                      garageRepository: GarageRepository(),
                    ),
                child: SelectServicePage(
                  garage: garage,
                )));

      case CONFIRM_REQUEST_ROUTE:
        ComfirmReq req = settings.arguments as ComfirmReq;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (BuildContext context) => RequestServiceBloc(
                              requestServiceRepository:
                                  RequestServiceRepository())),
                      BlocProvider(
                          create: (BuildContext context) => ServiceBloc(
                              serviceRepository: ServiceRepository())),
                      BlocProvider(
                          create: (BuildContext context) => GarageInfoBloc(
                              garageRepository: GarageRepository()))
                    ],
                    child: ConfirmRequestService(
                      req: req,
                    )));

      case WAITING_REQUEST_ROUTE:
        Map args = settings.arguments as Map;
        String requestServiceId = args['requestServiceId'] as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RequestServiceBloc(
                    requestServiceRepository: RequestServiceRepository()),
                child: WaitForGaragePage(requestServiceId: requestServiceId)));

      case TRACKING_REQUEST_ROUTE:
        Map args = settings.arguments as Map;
        String requestServiceId = args['requestServiceId'] as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RequestServiceBloc(
                    requestServiceRepository: RequestServiceRepository()),
                child:
                    TrackingRequestPage(requestServiceId: requestServiceId)));

      case REQUEST_COMPLETE_ROUTE:
        Map args = settings.arguments as Map;
        //String requestServiceId = args['requestServiceId'] as String;
        RequestService requestService =
            args['requestService'] as RequestService;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RequestServiceBloc(
                    requestServiceRepository: RequestServiceRepository()),
                child: DetailAndGiveStarPage(
                  requestService: requestService,
                )));

      case SHOWINFO_BEFOREREQ_ROUTE:
        return MaterialPageRoute(builder: (_) => SelectCarAndRecapBeforeReq());

      case EDITPROFILE_ROUTE:
        User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ProfileBloc(userRepository: UserRepository()),
                child: EditProfile(
                  user: user,
                )));

      case CHAT_ROUTE:
        return MaterialPageRoute(builder: (_) => ChatUi());

      case FIND_PROBLEM:
        int numOfFindProblem = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => FindProblemFormSelected(
                  findProblem: numOfFindProblem,
                ));

      case SUPPORT_CENTER_ROUTE:
        return MaterialPageRoute(builder: (_) => SupportCenterPage());

      case NOTIFY_ROUTE:
        NotifyInfo notify = settings.arguments as NotifyInfo;
        return MaterialPageRoute(
            builder: (_) => NotifyFromSelectPage(notify: notify));

      case HISTORY_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    historyBloc.RequestServiceBloc(
                        requestServiceRepository: RequestServiceRepository()),
                child: Listhistory()));
      case HISTORY_INFO_ROUTE:
        RequestService requestService = settings.arguments as RequestService;
        return MaterialPageRoute(
            builder: (_) => HistoryInfoPage(requestService: requestService));

      case GARAGE_SEARCH_ROUTE:
        String garageName = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      GarageListBloc(garagerRepository: GarageRepository()),
                  child: GarageFormSearch(garageName: garageName),
                ));

      default:
        return MaterialPageRoute(builder: (_) => InvalidRouteScreen());
    }
  }
}
