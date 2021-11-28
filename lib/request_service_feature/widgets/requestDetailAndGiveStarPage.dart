import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/models/review_add_model.dart';
import 'package:rodsiaapp/core/repository/review_repository.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/global_widgets/supportButton.dart';
import 'package:rodsiaapp/request_service_feature/bloc/review_bloc.dart';

class DetailAndGiveStarPage extends StatefulWidget {
  RequestService req;
  DetailAndGiveStarPage({Key? key, required this.req}) : super(key: key);

  @override
  _DetailAndGiveStarPageState createState() => _DetailAndGiveStarPageState();
}

class _DetailAndGiveStarPageState extends State<DetailAndGiveStarPage> {
  late ReviewBloc _reviewBloc;

  ReviewAdd _reviewAdd = ReviewAdd(
      id: "", text: "", star: 0, user: "", garage: "", requestService: "");

  @override
  void initState() {
    _reviewBloc = BlocProvider.of<ReviewBloc>(context);
    _reviewAdd.user = widget.req.user.id;
    _reviewAdd.garage = widget.req.service.garage!.id;
    _reviewAdd.requestService = widget.req.id;
    super.initState();
  }

  TextStyle _textTitle = TextStyle(
      color: textColorBlack, fontWeight: FontWeight.w600, fontFamily: 'Kanit');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title:
            Container(alignment: Alignment.centerRight, child: SupportButton()),
      ),
      body: BlocListener<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state is CreatedReview) {
            navigateToHome();
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(defualtPaddingLow),
              child: Form(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 60,
                      child: ClipOval(
                          child: _proFileImage(
                              widget.req.service.garage!.logoImage.toString())),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        widget.req.service.garage!.name,
                        style: TextStyle(fontSize: fontSizeXl),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      tGiveScore,
                    ),
                    SizedBox(height: 5),
                    GFRating(
                      color: primaryColor,
                      borderColor: primaryColor,
                      value: _reviewAdd.star.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _reviewAdd.star = value.toInt();
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defualtPaddingMedium),
                      child: TextFormField(
                        onChanged: (value) => {_reviewAdd.text = value},
                        cursorColor: primaryColor,
                        scrollPadding: EdgeInsets.only(top: 10),
                        maxLines: 3,
                        style: const TextStyle(
                            color: textColorBlack, fontSize: fontSizeS),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            labelText: tMoreInfoThai,
                            alignLabelWithHint: true,
                            fillColor: Colors.red,
                            contentPadding: EdgeInsets.all(defualtPaddingLow),
                            labelStyle: TextStyle(
                                fontSize: fontSizeS, color: textColorBlack),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor('#C4C4C4'), width: 0),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: defualtPaddingMedium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'บริการที่เลือก' + ':',
                                style: _textTitle,
                              ),
                              Text(widget.req.service.name),
                              SizedBox(
                                height: defualtPaddingLow,
                              ),
                              Text(
                                'ประเภท' + ':',
                                style: _textTitle,
                              ),
                              Text(widget.req.service.serviceType.name),
                              SizedBox(
                                height: defualtPaddingLow,
                              ),
                              Text(
                                'รูปภาพประกอบ' + ':',
                                style: _textTitle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              _addImageForReq(),
                              SizedBox(
                                height: defualtPaddingLow,
                              ),
                              Text(
                                'หมายเหตุ' + ':',
                                style: _textTitle,
                              ),
                              widget.req.problemDesc.isEmpty
                                  ? Text('ไม่มีรายละเอียดเพิ่มเติม')
                                  : Text(
                                      widget.req.problemDesc,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                              Text(
                                widget.req.problemDesc,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          height: buttonHeightSmall + 5,
                          width: buttonWidthLarge,
                          child: TextButton(
                            onPressed: () {
                              createReview(_reviewAdd);
                            },
                            child: Text(tSend),
                            style:
                                flatButtonStyle(primaryColor, textColorBlack),
                          ),
                        ),
                        GFButton(
                          onPressed: () {
                            navigateToHome();
                          },
                          child: Text(tBackToHomePage),
                          color: textColorBlack,
                          type: GFButtonType.transparent,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addImageForReq() {
    if (widget.req.images!.isNotEmpty) {
      return GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        children: List.generate(widget.req.images!.length, (index) {
          return CachedNetworkImage(
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            imageUrl: widget.req.images![index].image,
            placeholder: (context, url) => CircularProgressIndicator(
              color: textColorBlack,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        }),
      );
    } else {
      return Text('ไม่มีรูปภาพเพิ่มเติม');
    }
  }

  _proFileImage(String profileImage) {
    if (profileImage == '') {
      return Image.asset(
        tImageAsset('profile'),
        width: 100,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: profileImage,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }

  navigateToHome() {
    Navigator.pushReplacementNamed(context, HOMEPAGE_ROUTE);
  }

  createReview(ReviewAdd reviewAdd) {
    _reviewBloc.add(CreateReview(reviewAdd: reviewAdd));
  }
}
