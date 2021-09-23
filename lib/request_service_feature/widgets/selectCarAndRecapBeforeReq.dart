import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:direct_select/direct_select.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/profile_feature/widgets/showInfoCarCard.dart';

class SelectCarAndRecapBeforeReq extends StatefulWidget {
  SelectCarAndRecapBeforeReq({
    Key? key,
  }) : super(key: key);

  @override
  _SelectCarAndRecapBeforeReqState createState() =>
      _SelectCarAndRecapBeforeReqState();
}

class _SelectCarAndRecapBeforeReqState
    extends State<SelectCarAndRecapBeforeReq> {
  int selectedIndex = 0;

  List<String> mockupService = ['ยางแตก', 'หม้อน้ำเสีย', 'ระบบไฟฟ้า'];

  Car car = Car(id: "", brand: "", model: "", type: "", year: "", fuelType: "");
  List<Widget> _buildItems() {
    return mockUpCar
        .map((val) => SelectionItem(
              car: val,
            ))
        .toList();
  }

  TextStyle _textTitle = TextStyle(
      color: textColorBlack, fontWeight: FontWeight.w600, fontFamily: 'Kanit');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [],
        title: Text(
          tRecapOrder,
          style: TextStyle(color: textColorBlack),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defualtPaddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tSelectCarForRequest + ':', style: _textTitle),
            SizedBox(
              height: 5,
            ),
            ShowInfoCarCard(car: mockUpCar[selectedIndex]),
            SizedBox(
              height: 5,
            ),
            DirectSelect(
                itemExtent: 40.0,
                backgroundColor: bgColor,
                selectedIndex: selectedIndex,
                mode: DirectSelectMode.drag,
                child: SelectionItem(
                  isForList: false,
                  car: mockUpCar[selectedIndex],
                ),
                onSelectedItemChanged: (int? index) {
                  setState(() {
                    selectedIndex = index!;
                    car = mockUpCar[selectedIndex];
                    print(car.toJson());
                  });
                },
                items: _buildItems()),
            SizedBox(
              height: defualtPaddingLow,
            ),
            Text(
              tLocationCurrent + ':',
              style: _textTitle,
            ),
            Row(
              children: [
                Icon(Icons.map, size: 15),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '23456 แขวงนู่น เขตนี่',
                  softWrap: true,
                  maxLines: 3,
                ),
              ],
            ),
            SizedBox(
              height: defualtPaddingLow + 4,
            ),
            Text(
              'ร้านผู้ให้บริการ:',
              style: _textTitle,
            ),
            Text('168 Garage'),
            SizedBox(
              height: defualtPaddingLow + 4,
            ),
            Text(
              'บริการที่เลือก' + ':',
              style: _textTitle,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: mockupService.length,
                  itemBuilder: (context, index) => Row(
                        children: [
                          Icon(
                            Icons.report_problem_outlined,
                            size: 13,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(mockupService[index]),
                        ],
                      )),
            ),
            Text(
              'หมายเหตุ' + ':',
              style: _textTitle,
            ),
            Row(
              children: [
                Icon(
                  Icons.description,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'ยากแบนเพราะเกิดจากอะไรไม่รู้',
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: buttonHeightSmall + 5,
                  width: buttonWidthLarge,
                  child: TextButton(
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    },
                    child: Text(tRequestServiceThai),
                    style: flatButtonStyle(primaryColor, textColorBlack),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tRequestServiceThai));
    if (result == 'Ok') {}
  }
}

class SelectionItem extends StatelessWidget {
  final Car car;
  final bool isForList;

  const SelectionItem({Key? key, required this.car, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              elevation: 5,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(defualtPaddingLow)),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    TextStyle _textStyle = TextStyle(fontSize: 15, fontFamily: 'Kanit');
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(car.brand, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text(car.model, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text(car.year, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text('(${car.fuelType})', style: _textStyle)
        ],
      ),
    );
  }
}
