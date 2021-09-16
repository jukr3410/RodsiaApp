import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'otp.dart';

class AddNumber extends StatefulWidget {
  @override
  _AddNumberState createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneConTroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('image/logo.png'),
                  height: 125,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Text(
                    "RodSiaApp",
                    style: GoogleFonts.alata(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 40)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 40),
                        child: Text(
                          "Mobile",
                          style: GoogleFonts.alata(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                      Form(
                        key: _form,
                        child: TextFormField(
                            // maxLength: 15,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alata(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            inputFormatters: [
                              MaskedInputFormatter('(###)-###-####'),
                            ],
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_android),
                              filled: true,
                              fillColor: hexToColor("#F7D07A"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Enter moblie number',
                              hintStyle: GoogleFonts.alata(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please, input phone number."),
                              MinLengthValidator(14,
                                  errorText:
                                      "Phone should be atleast 10 number."),
                            ])),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Otp()));
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 2,
                            shadowColor: Colors.black,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.only(
                                left: 137, right: 137, top: 20, bottom: 20),
                            primary: Colors.orange.shade100,
                            backgroundColor: Colors.white,
                            onSurface: Colors.black,
                          ),
                          child: Text("Next",
                              style: GoogleFonts.alata(
                                textStyle: TextStyle(
                                    color: hexToColor("#F7D07A"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 40),
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
        ),
      ),
    );
  }
}
