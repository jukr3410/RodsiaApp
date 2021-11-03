import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/profile_feature/bloc/profile_bloc.dart';

class MenusSetting extends StatefulWidget {
  final User user;
  MenusSetting({Key? key, required this.user}) : super(key: key);

  @override
  _MenusSettingState createState() => _MenusSettingState();
}

class _MenusSettingState extends State<MenusSetting> {
  late AuthenticationBloc _authenticationBloc;
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          navigateToLogin();
        }
      },
      builder: (context, state) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.yellow.shade800,
                    Colors.yellow.shade400,
                    Colors.yellow.shade50
                  ])),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70,
                      child: ClipOval(
                        child: Image.asset(
                          tImageAsset('profile'),
                          height: 130,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      // widget.user.name,
                      "หม่ำ",
                      style: TextStyle(fontSize: fontSizeXl),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: borderRadiusHightOnlyTop,
                                color: bgColor),
                            child: Padding(
                                padding:
                                    const EdgeInsets.all(defualtPaddingHight),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.grey.shade400,
                                    ))),
                                    child: ListView.builder(
                                        itemCount: menusSetting.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                child: Text(
                                                  menusSetting[index]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: fontSizeM,
                                                    color: textColorBlack,
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (index ==
                                                      menusSetting.length - 1) {
                                                    _authenticationBloc
                                                        .add(LoggedOut());
                                                  } else {
                                                    navigator(
                                                        menusSettingRoute[index]
                                                            .toString());
                                                  }
                                                },
                                              ),
                                              Divider(
                                                color: textColorBlack,
                                              ),
                                            ],
                                          );
                                        })))),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void navigator(String route) {
    Navigator.pushNamed(context, route, arguments: widget.user);
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }
}
