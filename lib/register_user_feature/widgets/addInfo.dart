import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'otp.dart';

class AddInfo extends StatefulWidget {
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneConTroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/launcher/ic_launcher.png',
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              // child: Text(
              //   tRegistration,
              //   style: GoogleFonts.alata(
              //       textStyle: TextStyle(color: textColorBlack, fontSize: 30)),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Form(
                        key: _form,
                        child: Column(
                          children: [
                            TextFormField(
                                // maxLength: 25,
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.alata(
                                    textStyle: TextStyle(
                                        color: textColorBlack, fontSize: 15)),
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
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  hintText: "ชื่อ",
                                  hintStyle: GoogleFonts.alata(
                                      textStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15)),
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Please, input phone number."),
                                  MinLengthValidator(14,
                                      errorText:
                                          "Phone should be atleast 10 number."),
                                ])),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                // maxLength: 25,
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.alata(
                                    textStyle: TextStyle(
                                        color: textColorBlack, fontSize: 15)),
                                inputFormatters: [
                                  //MaskedInputFormatter('(###)-###-####')
                                ],
                                decoration: InputDecoration(
                                  // icon: Icon(Icons.phone_android),
                                  filled: true,
                                  prefixIcon:
                                      Icon(Icons.email, color: textColorBlack),
                                  fillColor: Colors.white,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  hintText: tEmail,
                                  hintStyle: GoogleFonts.alata(
                                      textStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15)),
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Please, input phone number."),
                                  MinLengthValidator(14,
                                      errorText:
                                          "Phone should be atleast 10 number."),
                                ])),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                // maxLength: 25,
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                obscureText: true,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.alata(
                                    textStyle: TextStyle(
                                        color: textColorBlack, fontSize: 15)),
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
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  hintText: tPassword,
                                  hintStyle: GoogleFonts.alata(
                                      textStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15)),
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Please, input password."),
                                  MinLengthValidator(14,
                                      errorText:
                                          "Phone should be atleast 10 number."),
                                ])),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          navigateToLogin();
                        }
                      },
                      style: TextButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.black,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.only(
                            left: 110, right: 110, top: 20, bottom: 20),
                        primary: textColorBlack,
                        backgroundColor: textColorBlack,
                        onSurface: Colors.black,
                      ),
                      child: Text(tRegistration,
                          style: GoogleFonts.alata(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Text(
                        "By continuing, you agree to RodSiaApp’s Terms of Use   and confirm that you have read our Privacy Policy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          textStyle: TextStyle(
                            color: textColorBlack,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateBackToOtp() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, LOGIN_ROUTE);
  }
}
