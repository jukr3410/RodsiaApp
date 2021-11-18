import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/bloc/profile_bloc.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editCarModel.dart';

class EditShowInfoNewCar extends StatefulWidget {
  EditCarNoNewCar car;
  EditShowInfoNewCar({Key? key, required this.car}) : super(key: key);

  @override
  _EditShowInfoNewCarState createState() => _EditShowInfoNewCarState();
}

class _EditShowInfoNewCarState extends State<EditShowInfoNewCar> {
  late ProfileBloc _profileBloc;
  late User _user;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context)
      ..add(ProfileLoadFormPhone());

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
          title: Text(
            tInfoEditcar,
            style: TextStyle(fontSize: fontSizeL),
          ),
          backgroundColor: textColorBlack,
        ),
        backgroundColor: Colors.transparent,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UserLoadSuccess) {
              _user = state.user;
              logger.d(_user.toJson());
            }
            if (state is ProfileUpdated) {
              navigatorToProfilePage(_user);
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 290,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: borderRadiusMedium),
                      color: bgColor,
                      child: Padding(
                        padding: const EdgeInsets.all(defualtPaddingMedium),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'แก้ไขรถคันที่: ${widget.car.index}',
                                style: TextStyle(fontSize: fontSizeXl),
                                textAlign: TextAlign.right,
                              ),
                              Image.asset(
                                tImageAsset(widget.car.carOld.type),
                                alignment: Alignment.center,
                                width: 250,
                              ),
                              Row(
                                children: [
                                  Text(
                                    tBrand,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.car.carOld.brand,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    tModel,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.car.carOld.model +
                                        ' ' +
                                        widget.car.carOld.year,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    tFuelType,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.car.carOld.fuelType,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'ป้ายทะเบียน: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.car.carOld.regisNumber,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: buttonWidthSmall,
                    height: buttonHeightSmall,
                    decoration: BoxDecoration(
                        color: textColorBlack,
                        borderRadius: borderRadiusMedium),
                    child: TextButton(
                        onPressed: () {
                          _navigateAndDisplaySelection(context);
                        },
                        child: Text(
                          tOKThai,
                          style: TextStyle(color: primaryColor),
                        )),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GFButton(
                      onPressed: () {
                        navigatorToBlack();
                      },
                      type: GFButtonType.transparent,
                      child: Text(
                        tEdit,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColorRed),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tUpdateTrackingStatus));
    if (result == 'Ok') {
      for (var i = 0; i < _user.cars!.length; i++) {
        if (_user.cars![i].id == widget.car.carOld.id) {
          _user.cars![i] = widget.car.carOld;
        }
      }
      _profileBloc.add(CarUpdate(_user));
    }
  }

  void navigatorToBlack() {
    Navigator.pop(context);
  }

  void navigatorToProfilePage(User user) {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: user);
  }
}
