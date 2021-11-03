import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/notify_feature/widgets/notifyPage.dart';
import 'package:intl/intl.dart';

class NotifyFromSelectPage extends StatefulWidget {
  final NotifyInfo notify;
  const NotifyFromSelectPage({Key? key, required this.notify})
      : super(key: key);

  @override
  _NotifyFromSelectPageState createState() => _NotifyFromSelectPageState();
}

class _NotifyFromSelectPageState extends State<NotifyFromSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'การแจ้งเตือน',
            style: TextStyle(color: textColorBlack, fontSize: fontSizeXl),
          ),
          iconTheme: IconThemeData(color: textColorBlack),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    child: Column(
                  children: [
                    Image.asset(
                      tImageAsset(widget.notify.typeNotify),
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      widget.notify.typeNotify,
                      style: TextStyle(fontSize: fontSizeS),
                    )
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.notify.title,
                  style: TextStyle(
                    fontSize: fontSizeXl + 2,
                  ),
                ),
                Text(
                  DateFormat('yyyy-MMM-dd  HH:MM น.')
                      .format(DateTime.parse(widget.notify.startDate.toString())),
                  style: TextStyle(color: Colors.grey, fontSize: fontSizeS - 2),
                ),
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: CachedNetworkImage(
                    imageUrl: widget.notify.image.toString(),
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: textColorBlack,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.notify.desc.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.notify.desc[index]),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      );
                    }),
                Text(
                  'เงื่อนไข:',
                  style: TextStyle(
                      color: primaryColor, fontSize: fontSizeL),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.notify.condition.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ' + widget.notify.condition[index],
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
