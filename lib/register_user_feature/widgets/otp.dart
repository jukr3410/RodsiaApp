import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/register_user_feature/bloc/register_bloc.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Otp extends StatefulWidget {
  User user;
  Otp({Key? key, required this.user}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  final _controller = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  late RegisterBloc _registerBloc;

  User _user = User(
      id: "",
      name: "",
      email: "",
      phone: "",
      password: "",
      otp: "",
      validatePhone: true,
      cars: [],
      profileImage: "");

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _user = widget.user;
    _registerBloc.add(RegisterSendOtp(user: _user));
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: textColorBlack),
            onPressed: () => navigateBackToAddPhone(),
          ),
        ),
        backgroundColor: primaryColor,
        body: Center(
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSendVerifyOtpSuccess) {
                showTopSnackBar(
                    context, CustomSnackBar.info(message: "ส่งรหัสยืนยันแล้ว"));
              } else if (state is RegisterVerifySuccess) {
                navigateToAddInfo(_user);
                showTopSnackBar(
                    context, CustomSnackBar.success(message: "ยืนยันสำเร็จ"));
              } else if (state is RegisterError) {
                showTopSnackBar(
                  context,
                  CustomSnackBar.error(
                    message: mError,
                  ),
                );
              } else if (state is RegisterVerifyFailed) {
                showTopSnackBar(
                  context,
                  CustomSnackBar.error(
                    message: "โปรใส่รหัสให้ถูกต้อง",
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    margin: new EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        borderRadius: borderRadiusHight,
                        boxShadow: [boxShadow]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/launcher/ic_launcher.png',
                        height: 150,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 0),
                          child: Text(
                            "กรุณาใส่รหัสยืนยันที่ถูกส่งไปยัง " + _user.phone,
                            style: TextStyle(
                                color: textColorBlack, fontSize: fontSizeL),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 30),
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: textColorWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 4,
                                // obscureText: true,
                                // obscuringCharacter: '*',
                                // obscuringWidget: FlutterLogo(
                                //   size: 24,
                                // ),
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.length < 3) {
                                    return "โปรดใส่ให้ครบ 4 ตัว";
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 60,
                                    fieldWidth: 50,
                                    inactiveColor: textColorWhite,
                                    activeColor: textColorWhite,
                                    selectedColor: textColorWhite,
                                    errorBorderColor: textColorRed,
                                    activeFillColor: textColorWhite,
                                    selectedFillColor: textColorWhite,
                                    inactiveFillColor: textColorWhite),
                                cursorColor: textColorBlack,

                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                errorAnimationController: errorController,
                                controller: textEditingController,
                                keyboardType: TextInputType.number,
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                // onTap: () {
                                //   print("Pressed");
                                // },
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    _user.otp = value;
                                  });
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              //navigateToAddInfo(_user);
                              verifyOTP(_user);
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
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            reSendVerifyOTP(_user);
                          },
                          onLongPress: () {
                            // open dialog OR navigate OR do what you want
                          },
                          child: Text("ส่งอีกครั้ง",
                              style: TextStyle(
                                color: textColorBlack,
                                fontSize: fontSizeL,
                                shadows: [
                                  Shadow(
                                    blurRadius: 15.0,
                                    color: Colors.blueGrey,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void navigateToAddInfo(User user) {
    //Navigator.pushNamed(context, REGISTER_ROUTE);
    Navigator.pushNamed(context, REGISTER_ROUTE, arguments: user);
  }

  void navigateBackToAddPhone() {
    Navigator.of(context).pop();
  }

  void verifyOTP(User user) {
    logger.d("Verify Code: ${_user.otp}");
    _registerBloc.add(RegisterVerifyOtp(user: _user));
  }

  void reSendVerifyOTP(User user) {
    logger.d("Re-send Verify Code to: ${_user.phone}");
    _registerBloc.add(RegisterSendOtp(user: _user));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }
}
