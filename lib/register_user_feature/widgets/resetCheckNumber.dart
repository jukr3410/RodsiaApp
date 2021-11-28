import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/register_user_feature/bloc/register_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ResetCheckNumber extends StatefulWidget {
  @override
  _ResetCheckNumberState createState() => _ResetCheckNumberState();
}

class _ResetCheckNumberState extends State<ResetCheckNumber> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  final _controller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneConTroller = TextEditingController();

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

  late RegisterBloc _registerBloc;
  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
      if (state is ResetNumberNotExist) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "หมายเลขไม่ถูกต้อง",
          ),
        );
      } else if (state is ResetNumberExist) {
        navigateToOtp(_user);
        // showTopSnackBar(
        //     context, CustomSnackBar.success(message: "หมายเลขถูกต้อง"));
      } else if (state is ResetError) {
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
              onPressed: () => navigateBackToLogin(),
            ),
          ),
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      // child: Text(
                      //   "RodSiaApp",
                      //   style: GoogleFonts.alata(
                      //       textStyle:
                      //           TextStyle(color: Colors.white, fontSize: 40)),
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 5, horizontal: 40),
                          //   child: Text(
                          //     tPhone,
                          //     style: GoogleFonts.alata(
                          //         textStyle: TextStyle(
                          //             color: textColorBlack, fontSize: fontSizeL)),
                          //   ),
                          // ),
                          Form(
                            key: _form,
                            child: TextFormField(
                                maxLength: 10,
                                onChanged: (value) => {_user.phone = value},
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.alata(
                                    textStyle: TextStyle(
                                        color: textColorBlack, fontSize: 20)),
                                // inputFormatters: [
                                //   MaskedInputFormatter('###-###-####'),
                                // ]
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_android,
                                    color: textColorBlack,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: 'ระบุเบอร์โทรศัพท์',
                                  hintStyle: TextStyle(
                                      color: textColorBlack, fontSize: 18),
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "โปรดระบุเบอร์โทรศัพท์"),
                                  MinLengthValidator(10,
                                      errorText: "โปรดระบุให้ครบ 10 ตัว"),
                                ])),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  checkPhoneNumber();
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
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 30, horizontal: 40),
                          //   child: Text(
                          //     "By continuing, you agree to RodSiaApp’s Terms of Use   and confirm that you have read our Privacy Policy",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         color: textColorBlack,
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.normal),
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }

  void checkPhoneNumber() {
    _registerBloc.add(ResetCheckPhoneNumber(user: _user));
  }

  void navigateToOtp(User user) {
    Navigator.pushNamed(context, FORGOT_OTP_ROUTE, arguments: user);
  }

  void navigateBackToLogin() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();

    super.dispose();
  }
}
