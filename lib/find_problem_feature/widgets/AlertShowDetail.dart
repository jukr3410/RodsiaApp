import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

class AlertShowDetailFindProblem extends StatefulWidget {
  final List<FindProblemDetail> datail;
  const AlertShowDetailFindProblem({Key? key, required this.datail})
      : super(key: key);

  @override
  _AlertShowDetailFindProblemState createState() =>
      _AlertShowDetailFindProblemState();
}

class _AlertShowDetailFindProblemState
    extends State<AlertShowDetailFindProblem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthLow,
        decoration: BoxDecoration(
          borderRadius: borderRadiusLow,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingLow),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'คำแนะนำ:',
                  style: TextStyle(
                      fontSize: fontSizeL,
                      fontWeight: FontWeight.bold,
                      color: textColorBlack),
                ),
              ),
              listDetail(),
              // Text(
              //   widget.datail,
              //   style: TextStyle(
              //       fontSize: fontSizeL,
              //       color: textColorBlack,
              //       fontWeight: FontWeight.w500,
              //       fontFamily: 'Kanit'),
              // ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: buttonHeightSmall - 10,
                    width: buttonWidthSmall - 20,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(tOKThai),
                      style: flatButtonStyle(primaryColor, textColorBlack),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listDetail() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.datail.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('- ' + widget.datail[index].title.toString()),
              Text(
                '>> ' + widget.datail[index].datail.toString(),
                style: TextStyle(color: Colors.grey.shade500),
              )
            ]),
          );
        });
  }
}
