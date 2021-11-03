import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

class SupportCenterPage extends StatefulWidget {
  const SupportCenterPage({Key? key}) : super(key: key);

  @override
  _SupportCenterPageState createState() => _SupportCenterPageState();
}

class _SupportCenterPageState extends State<SupportCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'ศูนย์ช่วยเหลือ',
          style: TextStyle(color: textColorBlack),
        ),
        iconTheme: IconThemeData(color: textColorBlack),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defualtPaddingMedium),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(tImageAsset('email-support')),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: ',
                      style: TextStyle(fontSize: fontSizeL),
                    ),
                    Text(
                      'asdfoiahjsdf@mail.com',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset(tImageAsset('phone-support')),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone: ',
                      style: TextStyle(fontSize: fontSizeL),
                    ),
                    Text(
                      '546-46464565',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
