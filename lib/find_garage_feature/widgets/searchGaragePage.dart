import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/search_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageList.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController garageConTroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: ImageIcon(
                        AssetImage(tImageAsset('backPage')),
                        size: 14,
                      ),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 30,
                      child: TextField(
                        onSubmitted: (String value) {
                          print(value);

                          SearchFetchEvent(garageName: garageConTroller.text);
                        },
                        autofocus: true,
                        controller: garageConTroller,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 2.0),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: textColorWhite,
                            border: OutlineInputBorder(
                              borderRadius: borderRadiusMedium,
                            ),
                            hintText: 'ค้นหา',
                            hintStyle: TextStyle(
                                color: hexToColor("#C4C4C4"), fontSize: 12)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: defualtPaddingMedium, top: 20),
              child: Text(
                "การค้นหาล่าสุด",
                style: TextStyle(
                    fontSize: 16,
                    color: hexToColor(codeColorBlack),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: ListView(
                  children: ListTile.divideTiles(context: context, tiles: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: historySearch.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 30,
                        child: ListTile(
                            title: Text(
                          historySearch[index].toString(),
                          style: TextStyle(fontSize: 14),
                        )),
                      );
                    }),
              ]).toList()),
            ),
          ],
        ),
      ),
    );
  }
}

// mockup
List historySearch = [
  'ยางแตก',
  'หม้อน้ำเสีย',
  'ระบบไฟฟ้า',
  'ระบบเบรค',
];
