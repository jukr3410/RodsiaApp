import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/register_user_feature/bloc/register_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'otp.dart';

class AddInfo extends StatefulWidget {
  User user;
  AddInfo({Key? key, required this.user}) : super(key: key);
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final _controller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneConTroller = TextEditingController();
  var confirmPass;

  User _user = User(
      id: "",
      name: "",
      email: "",
      phone: "",
      password: "",
      otp: "",
      validatePhone: true,
      cars: []);

  late RegisterBloc _registerBloc;
  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
      if (state is RegisterSuccess) {
        navigateToLogin();
        showTopSnackBar(
            context, CustomSnackBar.success(message: "สมัครสมาชิกสำเร็จ"));
      } else if (state is RegisterError) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: mError,
          ),
        );
      }
    }, builder: (context, state) {
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
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: textColorBlack),
              onPressed: () => navigateBackToOtp(),
            ),
          ),
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: borderRadiusHight, boxShadow: [boxShadow]),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(25),
                  //   child: Image.asset(
                  //     'assets/launcher/ic_launcher.png',
                  //     height: 150,
                  //   ),
                  // ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Form(
                            key: _form,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  child: Text(
                                    "ระบุข้อมูล",
                                    style: TextStyle(
                                        color: textColorBlack,
                                        fontSize: fontSizeL),
                                  ),
                                ),
                                TextFormField(
                                    // maxLength: 25,
                                    onChanged: (value) => {_user.name = value},
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                    inputFormatters: [
                                      //MaskedInputFormatter('(###)-###-####')
                                    ],
                                    decoration: InputDecoration(
                                      // icon: Icon(Icons.phone_android),
                                      filled: true,
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: textColorBlack,
                                      ),

                                      border: OutlineInputBorder(
                                          borderRadius: borderRadiusMedium,
                                          borderSide: BorderSide.none),
                                      hintText: "ชื่อ",
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "โปรระบุชื่อ"),
                                      MinLengthValidator(1,
                                          errorText: "โปรระบุชื่อ"),
                                    ])),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    // maxLength: 25,
                                    onChanged: (value) => {
                                          value.isEmpty
                                              ? _user.email = ""
                                              : _user.email = value
                                        },
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                    inputFormatters: [
                                      //MaskedInputFormatter('(###)-###-####')
                                    ],
                                    decoration: InputDecoration(
                                      // icon: Icon(Icons.phone_android),
                                      filled: true,
                                      prefixIcon: Icon(Icons.email,
                                          color: textColorBlack),
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius: borderRadiusMedium,
                                          borderSide: BorderSide.none),
                                      hintText: tEmail + " (ไม่จำเป็น)",
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    validator: MultiValidator([
                                      EmailValidator(
                                          errorText: 'โปรดระบุอีเมลให้ถูกต้อง')
                                      // RequiredValidator(errorText: ""),
                                      // MinLengthValidator(14,
                                      //     errorText:
                                      //         "Phone should be atleast 10 number."),
                                    ])),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    // maxLength: 25,
                                    onChanged: (value) =>
                                        {_user.password = value},
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    obscureText: true,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                    inputFormatters: [
                                      //MaskedInputFormatter('(###)-###-####')
                                    ],
                                    decoration: InputDecoration(
                                      // icon: Icon(Icons.phone_android),
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.security_rounded,
                                        color: textColorBlack,
                                      ),
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius: borderRadiusMedium,
                                          borderSide: BorderSide.none),
                                      hintText: tPassword,
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    validator: (String? value) {
                                      confirmPass = value;
                                      if (value!.isEmpty) {
                                        return "โปรดระบุรหัสผ่าน";
                                      } else if (value.length < 8) {
                                        return "โปรดระบุรหัส 8 ตัวขึ้นไป";
                                      } else {
                                        return null;
                                      }
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    // maxLength: 25,
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    obscureText: true,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                    inputFormatters: [
                                      //MaskedInputFormatter('(###)-###-####')
                                    ],
                                    decoration: InputDecoration(
                                      // icon: Icon(Icons.phone_android),
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.security_rounded,
                                        color: textColorBlack,
                                      ),
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius: borderRadiusMedium,
                                          borderSide: BorderSide.none),
                                      hintText: tConfirmPassword,
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "โปรดระบุรหัสผ่าน";
                                      } else if (value.length < 8) {
                                        return "โปรดระบุรหัส 8 ตัวขึ้นไป";
                                      } else if (value != confirmPass) {
                                        return "โปรดระบุรหัสผ่านให้ตรงกัน";
                                      } else {
                                        return null;
                                      }
                                    }),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              register();
                            }
                          },
                          style: TextButton.styleFrom(
                            shadowColor: Colors.black,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            primary: textColorBlack,
                            backgroundColor: textColorBlack,
                            onSurface: Colors.black,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  tNext,
                                  style: TextStyle(
                                      color: textColorWhite,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }));
  }

  void navigateBackToOtp() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }

  void register() {
    _registerBloc.add(RegisterButtonPressed(user: _user));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }
}
