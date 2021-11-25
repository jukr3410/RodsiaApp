import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_login.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/bloc/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';

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

  late ProfileBloc _profileBloc;
  String name = '';
  String email = '';
  String imageProfile = '';
  bool addImageProfile = false;
  bool deleteImageProfile = false;
  User _user = mockUpUser;

  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        setState(() {
          _image = File(photo.path);
          addImageProfile = true;
        });
      }
    } catch (e) {}
  }

  File? _image;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageProfile = widget.user.profileImage.toString();
    _user = widget.user;
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
            onPressed: () => navigatorToProfilePage(widget.user),
          ),
        ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              _profileBloc.add(ProfileLoadFormPhone());
            }
            if (state is UserLoadSuccess) {
              navigatorToProfilePage(widget.user);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  _showImageProfile(imageProfile),
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
                                    onChanged: (String value) {
                                      name = value;
                                      logger.d('name: ' + _nameConTroller.text);
                                    },
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
                                    onChanged: (String value) {
                                      email = value;
                                      logger
                                          .d('email: ' + _emailConTroller.text);
                                    },
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GFButton(
                                      onPressed: () {
                                        _navigatorToEditPassword();
                                      },
                                      child: Text('เปลี่ยนรหัสผ่าน'),
                                      type: GFButtonType.transparent,
                                      color: textColorBlack,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              if (name == '' &&
                                  email == '' &&
                                  addImageProfile == false &&
                                  deleteImageProfile == false) {
                                _navigateAndDisplayEditError(context);
                              } else {
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

  void _navigateAndDisplayEdit(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopupYesNo(
              title: 'คุณต้องการอัพเดตข้อมูลใช้ไหม',
            ));
    if (result == 'Ok') {
      if (name != '') {
        _user.name = name;
      }
      if (email != '') {
        _user.email = email;
      }
      if (deleteImageProfile == true) {
        _user.profileImage = '';
      }
      logger.d(_user.toJson());
      _profileBloc.add(UserUpdateNoPassword(
          user: _user,
          image: deleteImageProfile == true || addImageProfile == false
              ? null
              : _image!));
    }
  }

  void _navigatorToEditPassword() {
    Navigator.pushNamed(context, EDIT_PASSWOED_ROUTE, arguments: widget.user);
  }

  void _navigateAndDisplayEditError(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopupYesNo(
              title: 'คุณต้องใล่ข้อมูล',
            ));
    if (result == 'Ok') {}
  }

  void _navigateToErrorPassword(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _AlertErrorPinPassword());
    if (result == 'Ok') {
      _navigateAndDisplayEdit(context);
    }
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

  _proFileImage(String profileImage) {
    if (profileImage == '' && addImageProfile == false ||
        deleteImageProfile == true && addImageProfile == false) {
      return Image.asset(
        tImageAsset('profile'),
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      );
    } else if (addImageProfile == true) {
      return Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
        width: 120,
        height: 120,
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

  _showImageProfile(String profileImage) {
    if (profileImage == '' && addImageProfile == false ||
        deleteImageProfile == true && addImageProfile == false) {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 80,
            child: ClipOval(child: _proFileImage(profileImage)),
          ),
          Positioned(
              bottom: 20,
              right: 30,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: textColorBlack),
                child: Align(
                  alignment: Alignment.center,
                  child: new IconButton(
                      onPressed: getImage,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: bgColor,
                        size: 15,
                      )),
                ),
              )),
        ],
      );
    } else {
      return Column(
        children: [
          Stack(
            children: [
              ClipOval(child: _proFileImage(profileImage)),
              Positioned(
                  right: 10,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: redStatus),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            addImageProfile = false;
                            deleteImageProfile = true;
                            profileImage = '';
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: bgColor,
                          size: 15,
                        )),
                  )),
            ],
          ),
          GFButton(
            onPressed: getImage,
            child: Text('เปลี่ยนรูปภาพ'),
            textStyle: TextStyle(color: textColorBlack, fontSize: fontSizeM),
            type: GFButtonType.transparent,
          )
        ],
      );
    }
  }
}
