import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_login.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/bloc/profile_bloc.dart';

class EditProfile extends StatefulWidget {
  User user;
  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  GlobalKey<FormState> _formPassword = GlobalKey<FormState>();
  final _nameConTroller = TextEditingController();
  final _emailConTroller = TextEditingController();
  final _passwordConTroller = TextEditingController();

  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);

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
        appBar: AppBar(
          centerTitle: true,
          title: Text('แก้ไขข้อมูล'),
          backgroundColor: textColorBlack,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: bgColor),
            onPressed: () => navigateBack(),
          ),
        ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is CheckPasswordSuccesss && state.status == false) {
              logger.d(state.status);
              _navigateToErrorPassword(context);
            } else {
              if (_nameConTroller.text != '') {
                widget.user.name = _nameConTroller.text;
              }
              if (_emailConTroller.text != '') {
                widget.user.email = _emailConTroller.text;
              }
              _profileBloc.add(CarUpdate(widget.user));
            }
            if (state is ProfileUpdated
            ) {
              navigatorToProfilePage(widget.user);
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 80,
                        child: ClipOval(
                          child: Image.asset(
                            tImageAsset('profile'),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      _addOrChangeProfileImage(
                          widget.user.profileImage.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 30,
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
                                  TextFormField(
                                    // onChanged: (String value) {
                                    //   _nameConTroller.text = value;
                                    //   logger.d('name: ' + _nameConTroller.text);
                                    // },
                                    controller: _nameConTroller,
                                    keyboardType: TextInputType.name,
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
                                      hintText: widget.user.name,
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    // validator: MultiValidator([
                                    //   RequiredValidator(
                                    //       errorText: "โปรดใส่ชื่อใหม่ของคุณ"),
                                    // ])
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    // maxLength: 25,
                                    // onChanged: (String value) {
                                    //   _emailConTroller.text = value;
                                    //   logger.d('email: ' + _emailConTroller.text);
                                    // },
                                    controller: _emailConTroller,
                                    keyboardType: TextInputType.emailAddress,
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
                                      hintText: widget.user.email,
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    // validator: MultiValidator([
                                    //   RequiredValidator(
                                    //       errorText: "โปรดใส่อีเมลใหม่ของคุณ"),
                                    // ])
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // TextFormField(
                                  //     // maxLength: 25,
                                  //     keyboardType: TextInputType.visiblePassword,
                                  //     autofocus: true,
                                  //     obscureText: true,
                                  //     textAlign: TextAlign.start,
                                  //     style: TextStyle(
                                  //         color: textColorBlack, fontSize: 15),
                                  //     inputFormatters: [
                                  //       //MaskedInputFormatter('(###)-###-####')
                                  //     ],
                                  //     decoration: InputDecoration(
                                  //       // icon: Icon(Icons.phone_android),
                                  //       filled: true,
                                  //       prefixIcon: Icon(
                                  //         Icons.security_rounded,
                                  //         color: textColorBlack,
                                  //       ),
                                  //       fillColor: Colors.white,
                                  //       alignLabelWithHint: true,
                                  //       border: OutlineInputBorder(
                                  //           borderRadius: borderRadiusMedium,
                                  //           borderSide: BorderSide.none),
                                  //       hintText: 'รหัสผ่านเก่า',
                                  //       hintStyle: TextStyle(
                                  //           color: textColorBlack, fontSize: 15),
                                  //     ),
                                  //     validator: MultiValidator([
                                  //       RequiredValidator(
                                  //           errorText: "Please, input password."),
                                  //       MinLengthValidator(14,
                                  //           errorText:
                                  //               "Phone should be atleast 10 number."),
                                  //     ])
                                  //     ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // TextFormField(
                                  //     // maxLength: 25,
                                  //     keyboardType: TextInputType.name,
                                  //     autofocus: true,
                                  //     obscureText: true,
                                  //     textAlign: TextAlign.start,
                                  //     style: TextStyle(
                                  //         color: textColorBlack, fontSize: 15),
                                  //     inputFormatters: [
                                  //       //MaskedInputFormatter('(###)-###-####')
                                  //     ],
                                  //     decoration: InputDecoration(
                                  //       // icon: Icon(Icons.phone_android),
                                  //       filled: true,
                                  //       prefixIcon: Icon(
                                  //         Icons.security_rounded,
                                  //         color: textColorBlack,
                                  //       ),
                                  //       fillColor: Colors.white,
                                  //       alignLabelWithHint: true,
                                  //       border: OutlineInputBorder(
                                  //           borderRadius: borderRadiusMedium,
                                  //           borderSide: BorderSide.none),
                                  //       hintText: 'รหัสผ่านใหม่',
                                  //       hintStyle: TextStyle(
                                  //           color: textColorBlack, fontSize: 15),
                                  //     ),
                                  //     validator: MultiValidator([
                                  //       RequiredValidator(
                                  //           errorText: "Please, input password."),
                                  //       MinLengthValidator(14,
                                  //           errorText:
                                  //               "Phone should be atleast 10 number."),
                                  //     ])),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              if (_form.currentState!.validate()) {
                                _navigateAndDisplayEdit(context);
                              }
                            },
                            style: TextButton.styleFrom(
                              fixedSize:
                                  Size(buttonWidthMedium, buttonHeightMedium),
                              elevation: 2,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(),
                              primary: textColorBlack,
                              backgroundColor: textColorBlack,
                              onSurface: Colors.black,
                            ),
                            child: Text(
                              'แก้ไขข้อมูล',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                        GFButton(
                          onPressed: () {
                            navigateBack();
                          },
                          child: Text(
                            tCancleThai,
                            style: TextStyle(
                                color: textColorBlack,
                                fontFamily: 'Kanit',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          type: GFButtonType.transparent,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _addOrChangeProfileImage(String profileImage) {
    if (profileImage == '') {
      return Positioned(
          bottom: 5,
          right: 25,
          child: Container(
            height: 35,
            width: 35,
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            decoration: BoxDecoration(
                color: textColorBlack, borderRadius: borderRadiusHight),
          ));
    } else {
      return GFButton(
        onPressed: () {},
        type: GFButtonType.transparent,
        textStyle: TextStyle(color: textColorBlack, fontSize: fontSizeS),
        child: Text('เปลี่ยนรูปภาพ'),
      );
    }
  }

  void _navigateAndDisplayEdit(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _AlertFormPinPassword());
    if (result == 'Ok') {
      logger.d(_passwordConTroller.text);
      UserLogin userLogin = UserLogin(
          phone: widget.user.phone, password: _passwordConTroller.text);

      _profileBloc.add(CheckPassword(userLogin: userLogin));
      logger.d(userLogin.toJson());
    }
  }

  void _navigateToErrorPassword(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _AlertErrorPinPassword());
    if (result == 'Ok') {}
  }

  Widget _AlertFormPinPassword() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: cardWidthLow,
          decoration: BoxDecoration(
            borderRadius: borderRadiusMedium,
            boxShadow: [boxShadow],
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(defualtPaddingLow),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ใส่รหัสผ่าน: ',
                  style: TextStyle(
                      fontSize: fontSizeL,
                      color: textColorBlack,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kanit'),
                ),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Form(
                  key: _formPassword,
                  child: TextFormField(
                      obscureText: true,
                      controller: _passwordConTroller,
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: textColorBlack, fontSize: 15),
                      inputFormatters: [
                        //MaskedInputFormatter('(###)-###-####')
                      ],
                      decoration: InputDecoration(
                        // icon: Icon(Icons.phone_android),
                        filled: true,
                        prefixIcon: Icon(Icons.security, color: textColorBlack),
                        fillColor: primaryColor,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: borderRadiusMedium,
                            borderSide: BorderSide.none),
                        hintText: 'รหัสผ่าน',
                        hintStyle:
                            TextStyle(color: textColorBlack, fontSize: 15),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "โปรดใส่รหัสผ่านของคุณ"),
                      ])),
                ),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: buttonHeightSmall,
                        width: buttonWidthSmall,
                        child: TextButton(
                          onPressed: () {
                            if (_formPassword.currentState!.validate()) {
                              Navigator.pop(context, 'Ok');
                            }
                          },
                          child: Text(tOKThai),
                          style: flatButtonStyle(primaryColor, textColorBlack),
                        )),
                    GFButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancal');
                      },
                      child: Text(tCancleThai),
                      textColor: textColorBlack,
                      type: GFButtonType.transparent,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _AlertErrorPinPassword() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: cardWidthLow,
          decoration: BoxDecoration(
            borderRadius: borderRadiusMedium,
            boxShadow: [boxShadow],
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(defualtPaddingLow),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'รหัสผ่านผิด!, โปรดลองใหม่อีกครั้ง: ',
                  style: TextStyle(
                      fontSize: fontSizeL,
                      color: textColorBlack,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kanit'),
                ),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Container(
                    height: buttonHeightSmall,
                    width: buttonWidthSmall,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Ok');
                      },
                      child: Text(tOKThai),
                      style: flatButtonStyle(primaryColor, textColorBlack),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateBack() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, LOGIN_ROUTE);
  }

  void navigatorToProfilePage(User user) {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: user);
  }
}
