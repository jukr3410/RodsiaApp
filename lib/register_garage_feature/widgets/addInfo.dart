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
      backgroundColor: Colors.orange.shade100,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('image/logo.png'),
              height: 125,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Text(
                "Registration",
                style: GoogleFonts.alata(
                    textStyle: TextStyle(color: Colors.white, fontSize: 40)),
              ),
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
                                        color: primaryColor, fontSize: 15)),
                                inputFormatters: [
                                  MaskedInputFormatter('(###)-###-####')
                                ],
                                decoration: InputDecoration(
                                  // icon: Icon(Icons.phone_android),
                                  filled: true,
                                  fillColor: Colors.white,
                                  alignLabelWithHint: true,
                                  prefixIcon: Icon(Icons.person),

                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  hintText: 'UserName',
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
                                        color: primaryColor, fontSize: 15)),
                                inputFormatters: [
                                  MaskedInputFormatter('(###)-###-####')
                                ],
                                decoration: InputDecoration(
                                  // icon: Icon(Icons.phone_android),
                                  filled: true,
                                  prefixIcon: Icon(Icons.email),
                                  fillColor: Colors.white,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  hintText: 'Email',
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
                                        color: primaryColor, fontSize: 15)),
                                inputFormatters: [
                                  MaskedInputFormatter('(###)-###-####')
                                ],
                                decoration: InputDecoration(
                                  // icon: Icon(Icons.phone_android),
                                  filled: true,
                                  prefixIcon: Icon(Icons.security_rounded),
                                  fillColor: Colors.white,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  hintText: 'Password',
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Otp()));
                        }
                      },
                      style: TextButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.black,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.only(
                            left: 110, right: 110, top: 20, bottom: 20),
                        primary: Colors.orange.shade100,
                        backgroundColor: primaryColor,
                        onSurface: Colors.black,
                      ),
                      child: Text("Register",
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
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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
}
