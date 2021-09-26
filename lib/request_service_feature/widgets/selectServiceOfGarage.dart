import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/main.dart';

class SelectServiceOfGarage extends StatefulWidget {
  List<Service> services;
  SelectServiceOfGarage({Key? key, required this.services}) : super(key: key);

  @override
  _SelectServiceOfGarageState createState() => _SelectServiceOfGarageState();
}

class _SelectServiceOfGarageState extends State<SelectServiceOfGarage> {
  Map<String, bool> mockupList = {
    'ยาง': false,
    'แบตเตอรี่': false,
    'ทุกเซอร์วิส': false,
    'เติมน้ำมัน': false,
    'เครื่องยนต์': false,
    'รถลาก': false,
    // 'รถยก': false,
  };
  int val = -1;
  Map<String, bool> test = {};

  var holder_1 = [];

  getItems() {
    test.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i <= widget.services.length - 1; i++) {
      test[widget.services[i].toString()] = false;
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: defualtPaddingMedium,
        right: defualtPaddingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: defualtPaddingLow),
            child: Text(
              tServiceOfGarageThai,
              style: TextStyle(fontSize: fontSizeL),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 220,
            child: ListView.builder(
                itemCount: widget.services.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    // margin: new EdgeInsets.symmetric(vertical: 4.0),
                    color: cardColor,
                    child: ListTile(
                      title: _makeCardWidget(widget.services[index]),
                      trailing: Radio(
                          value: index,
                          groupValue: val,
                          onChanged: (int? value) {
                            setState(() {
                              val = value!;
                              logger.d(widget.services[index].name);
                            });
                          }),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(fontSize: 12),
            maxLines: 2,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defualtPaddingLow),
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              helperText: 'เช่น ยางรั่ว, ยางระเบิด, เบรคไม่อยู่, สตาร์ทไม่ติด',
              helperStyle: TextStyle(fontSize: 10),
              hintText:
                  'รายละเอียดเพิ่มเติม(ไม่จำเป็น) เช่น ยางรั่ว, ยางระเบิด, เบรคไม่อยู่, สตาร์ทไม่ติด',
              labelText: 'รายละเอียดเพิ่มเติม',
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                // margin: EdgeInsets.only(bottom: defualtPaddingHight+20),
                width: double.infinity,
                height: buttonHeightSmall,
                child: TextButton(
                  onPressed: () {
                    navigateToConfirmRequest();
                  },
                  style: flatButtonStyle(primaryColor, textColorBlack),
                  child: Text(tNext),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _makeCardWidget(Service service) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.build_circle_outlined, size: 40, color: iconColorBlack),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  maxLines: 1,
                  softWrap: false,
                  style: new TextStyle(
                      fontSize: fontSizeM,
                      fontWeight: FontWeight.w600,
                      color: textColorBlack),
                ),
                Container(
                  child: Text(
                    service.description.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                        fontSize: fontSizeS,
                        fontWeight: FontWeight.normal,
                        color: textColorBlack),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
      onTap: () {
        //Navigator.pushNamed(context, EDIT_SERVICE_ROUTE);
        // navigateToServiceEdit(service);
      },
    );
  }

  navigateToConfirmRequest() {
    Navigator.pushNamed(context, CONFIRM_REQUEST_ROUTE,
        arguments: {'garage': null});
  }
}
