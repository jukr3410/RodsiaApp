import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/bloc/profile_bloc.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editCarModel.dart';

class InfoCarCard extends StatefulWidget {
  final User user;
  InfoCarCard({Key? key, required this.user}) : super(key: key);

  @override
  _InfoCarCardState createState() => _InfoCarCardState();
}

class _InfoCarCardState extends State<InfoCarCard> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          // navigatorToProfilePage();
        }
      },
      builder: (context, state) {
        return Container(
          height: 380,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.user.cars!.length,
              itemBuilder: (context, index) {
                final _infoCar = widget.user.cars![index];
                return Container(
                  width: 290,
                  height: 380,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: borderRadiusMedium),
                    color: bgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(defualtPaddingMedium),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'รถคันที่: ${index + 1}',
                              style: TextStyle(fontSize: fontSizeXl),
                              textAlign: TextAlign.right,
                            ),
                            Image.asset(
                              tImageAsset(_infoCar.type),
                              alignment: Alignment.center,
                              width: 150,
                            ),
                            Row(
                              children: [
                                Text(
                                  tBrand,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _infoCar.brand,
                                  style: TextStyle(color: Colors.grey.shade600),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  tModel,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _infoCar.model + ' ' + _infoCar.year,
                                  style: TextStyle(color: Colors.grey.shade600),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  tFuelType,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _infoCar.fuelType,
                                  style: TextStyle(color: Colors.grey.shade600),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'ป้ายทะเบียน: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _infoCar.regisNumber,
                                  style: TextStyle(color: Colors.grey.shade600),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: buttonWidthSmall,
                                  height: buttonHeightSmall,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: borderRadiusMedium),
                                  child: TextButton(
                                      onPressed: () {
                                        _navigateAndDisplayEdit(context, index);
                                      },
                                      child: Text(
                                        tEdit,
                                        style: TextStyle(color: textColorBlack),
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GFButton(
                                    onPressed: () {
                                      _navigateAndDisplayDelete(context, index);
                                    },
                                    type: GFButtonType.transparent,
                                    child: Text(
                                      tRemove,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: textColorRed),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  void _navigateAndDisplayDelete(BuildContext context, int index) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tDeleteThisCar));
    if (result == 'Ok') {
      logger.d(widget.user.cars![index].toJson());
      widget.user.cars!.removeAt(index);
      _profileBloc.add(CarUpdate(widget.user));
    }
  }

  void _navigateAndDisplayEdit(BuildContext context, int index) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tEditThisCar));
    if (result == 'Ok') {
      Navigator.pushNamed(context, EDITCAR_CARTYPE_ROUTE,
          arguments: EditCarNoNewCar(
              carOld: widget.user.cars![index], index: index + 1));
    }
  }

  void navigatorToProfilePage() {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: widget.user);
  }
}
