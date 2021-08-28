import 'package:flutter/material.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

//api base url
//dev localhost api
final baseUrlConstant = "http://localhost:3000/api";

// production api
//final baseUrlConstant = '';

// color that use in app
const textColorBlack = Color(0xff38454C);
const codeColorBlack = "#38454C";
const codeColorGray = '#C4C4C4';
const textColorWhite = Colors.white;
const textColorRed = Color(0xffDA5B49);

const primaryColor = Color(0xffFECE2F);
const colorGray = Color(0xffC4C4C4);
const bgColor = Color(0xffF2F4F6);
const bgCodeColor = '#F2F4F6';
const primaryCodeColor = '#FECE2F';

const cardColor = Colors.white;

// Style
const boxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.25),
  blurRadius: 6,
  offset: Offset(0, 2),
);
const borderRadiusHight = BorderRadius.all(Radius.circular(25));
const borderRadiusMedium = BorderRadius.all(Radius.circular(10));
const borderRadiusLow = BorderRadius.all(Radius.circular(5));

// margin, padding
const defualtPaddingMedium = 20.0;
const defualtPaddingHight = 30.0;
const defualtPaddingLow = 10.0;

// message, wording
const mError = "Service unvalidable, please try agian.";
const mNoGarages = "no garages";
const mNoMoreGarages = "no more garages";
const mLoading = "loading";
const mNotFound = "not found!";

// src string for set widget
const tOKThai = 'ตกลง';
const tServiceOfGarage = 'บริการของร้าน';
const tAlertRequestService = 'มีคนต้องการความช่วยเหลือ!';
const tRequestServiceThai = 'ขอรับบริการ';
const tDeclineThai = 'ปฏิเสธิ';
const tAddressThai = 'ที่อยู่: ';
const tUpdateThai = 'อัพเดต';
const tCancleThai = 'ยกเลิก';
const tAcceptThai = 'ยอมรับ';
const tYesThai = 'ใช้';
const tMessage = "messages";
const tEmail = "E-mail";
const tPassword = "Password";
const tNameGarageThai = "ชื่ออู๋:";
const tNameUserThai = "ชื่อลูกค้า:";
const tLocationThai = 'ตำแหน่ง:';
const tProblemThai = 'ปัญหา:';

//Tracking Status

const trackingStatus = [
  'กำลังเตรียมของ',
  'กำลังเดินทาง',
  'ถึงที่หมายแล้ว',
  'งานเสร็จแล้ว'
];
