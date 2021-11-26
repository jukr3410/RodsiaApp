import 'package:flutter/material.dart';
import 'package:rodsiaapp/assistant_mockup.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/find_problem_feature/widgets/AlertShowDetail.dart';
import 'package:rodsiaapp/main.dart';

class FindProblemFormSelected extends StatefulWidget {
  final int findProblem;
  const FindProblemFormSelected({Key? key, required this.findProblem})
      : super(key: key);

  @override
  _FindProblemFormSelectedState createState() =>
      _FindProblemFormSelectedState();
}

class _FindProblemFormSelectedState extends State<FindProblemFormSelected> {
  FindProblem listDetail = FindProblem(id: 0, detail: []);
  List<FindProblemWhereAndSolution> _detail = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColorBlack),
        centerTitle: true,
        title: Text('ค้นหาปัญหาของรถ'),
        titleTextStyle: TextStyle(
            color: textColorBlack, fontSize: fontSizeXl, fontFamily: 'Kanit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defualtPaddingLow),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(mockupFindProblem[widget.findProblem]),
              _makeCardWidget()
            ],
          ),
        ),
      ),
    );
  }

  _makeCardWidget() {
    for (int i = 0; i < mockupChoiceFindProblem.length; i++) {
      if (mockupChoiceFindProblem[i].id == widget.findProblem) {
        listDetail = mockupChoiceFindProblem[i];
        print(listDetail);
      }
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listDetail.detail.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200, borderRadius: borderRadiusMedium),
            width: double.infinity,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.build_circle_outlined,
                        size: 40, color: iconColorBlack),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        listDetail.detail[index].fect,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
              onTap: () {
                _detail = listDetail.detail[index].whereSolution;
                _navigateAndDisplaySelection(context, _detail);
                //Navigator.pushNamed(context, EDIT_SERVICE_ROUTE);
                // navigateToServiceEdit(service);
              },
            ),
          ),
        );
      },
    );
  }

  void _navigateAndDisplaySelection(
      BuildContext context, List<FindProblemWhereAndSolution> detail) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertShowDetailFindProblem(datail: detail));
    if (result == 'Ok') {
      Navigator.pop(context);
    }
  }
}
