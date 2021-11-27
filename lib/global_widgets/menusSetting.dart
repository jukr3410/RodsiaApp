import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/bloc/profile_bloc.dart';

class MenusSetting extends StatefulWidget {
  MenusSetting({
    Key? key,
  }) : super(key: key);

  @override
  _MenusSettingState createState() => _MenusSettingState();
}

class _MenusSettingState extends State<MenusSetting> {
  late AuthenticationBloc _authenticationBloc;
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context)
      ..add(ProfileLoadFormPhone());
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
          builder: (context, stateUser) {
            if (stateUser is UserLoadSuccess) {
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
                            child: _proFileImage(
                                stateUser.user.profileImage.toString())),
                      ),
                      Text(
                        stateUser.user.name,
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
                                                        menusSetting.length -
                                                            1) {
                                                      logger.d(
                                                          menusSetting.length -
                                                              1);
                                                      _authenticationBloc
                                                          .add(LoggedOut());
                                                    } else {
                                                      navigator(
                                                          menusSettingRoute[
                                                                  index]
                                                              .toString(),
                                                          stateUser.user);
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
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          },
        );
      },
    );
  }

  _proFileImage(String profileImage) {
    if (profileImage == '') {
      return Image.asset(
        tImageAsset('profile'),
        width: 120,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: profileImage,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: 120,
        width: 120,
      );
    }
  }

  void navigator(String route, User user) {
    Navigator.pushNamed(context, route, arguments: user);
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }
}
