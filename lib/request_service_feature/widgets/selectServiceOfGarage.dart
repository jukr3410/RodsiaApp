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
        left: defualtPaddingHight,
        right: defualtPaddingHight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: defualtPaddingLow),
            child: Text(
              tServiceOfGarageThai,
              style: TextStyle(fontSize: 17),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: Expanded(
                child: ListView.builder(
                    itemCount: widget.services.length,
                    itemBuilder: (context, index) {
                      return ListTile(
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
                      );
                    })),
          ),
          // ListView(
          //   shrinkWrap: true,
          //   children: List.keys.map((String key) {
          //     return
          //         // Container(height: 35, child: Text('service list')
          //         new CheckboxListTile(
          //       controlAffinity: ListTileControlAffinity.leading,
          //       title: new Text(key),
          //       value: List[key],

          //       activeColor: hexToColor(primaryCodeColor),
          //       checkColor: Colors.white,
          //       onChanged: (bool? value) {
          //         setState(() {
          //           List[key] = value!;
          //         });
          //       },
          //     );
          //   }).toList(),
          // ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
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
                margin: EdgeInsets.only(bottom: defualtPaddingHight),
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
      child: Card(
        elevation: 3,
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        color: cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Icon(Icons.build_circle_outlined,
                    size: 40, color: iconColorBlack),
              ),
            ),
            Flexible(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: new TextStyle(
                        fontSize: fontSizeL,
                        fontWeight: FontWeight.w600,
                        color: textColorBlack),
                  ),
                  // Container(
                  //     margin: new EdgeInsets.only(top: 4),
                  //     child: Row(children: [
                  //       Text(
                  //         service.serviceType.name,
                  //         style: new TextStyle(
                  //             fontSize: fontSizeL,
                  //             fontWeight: FontWeight.w600,
                  //             color: textColorBlack),
                  //       ),
                  //     ])),
                  Container(
                    margin: new EdgeInsets.only(top: 0),
                    child: Text(
                      service.description.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: textColorBlack),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
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
