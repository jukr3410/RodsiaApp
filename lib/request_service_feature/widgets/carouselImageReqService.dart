import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';

class CarouselImageReqService extends StatefulWidget {
  List<ImageGarage> images;

  CarouselImageReqService({required this.images});
  @override
  State<StatefulWidget> createState() {
    return CarouselImageReqServiceState();
  }
}

class CarouselImageReqServiceState extends State<CarouselImageReqService> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        CarouselSlider.builder(
            itemCount: widget.images.length,
            options: CarouselOptions(
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPos = index;
                  });
                }),
            itemBuilder: (context, index, realIndex) =>
                MyImageView(widget.images[index].image)),
      ]),
    );
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imgPath,
      placeholder: (context, url) => CircularProgressIndicator(
        color: textColorBlack,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
