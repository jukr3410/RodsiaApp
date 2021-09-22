import 'package:flutter/material.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

import 'core/models/car_model.dart';

//api base url
//dev localhost api
final baseUrlConstant = "http://localhost:3000/api";

// production api
//final baseUrlConstant = '';

// router path
const LOGIN_ROUTE = "/login";
const ADD_NUMBER_ROUTE = "/add_number";
const OTP_ROUTE = "/otp";
const REGISTER_ROUTE = "/register";
const EDIT_GARAGE_ROUTE = "/edit_garage";
const SERVICE_LIST_ROUTE = "/service_list";
const ADD_SERVICE_ROUTE = "/add_service";
const EDIT_SERVICE_ROUTE = "/edit_service";
const HISTORY_ROUTE = "/history";
const HISTORY_INFO_ROUTE = "/history_info";
const MAIN_ROUTE = "/app";
const HOMEPAGE_ROUTE = "/homepage";
const PROFILE_ROUTE = "/profile";
const ADDCAR_CARTYPE_ROUTE = "/addcar_cartype";
const ADDCAR_MORECHOICE_ROUTE = "/addcar_morechoice";
const ADDCAR_SHOWINFO_NEWCAR_ROUTE = "/addcar_showinfo";
const DELETECAR_ROUTE = "/delete_car";
const EDITCAR_ROUTE = "/edit_car";
const GARAGE_INFO_ROUTE = "/garage_info";
const CONFIRM_REQUEST_ROUTE = "/confirm_request";
const WAITING_REQUEST_ROUTE = "/waiting_request";
const TRACKING_REQUEST_ROUTE = "/tracking_request";
const EDITCAR_CARTYPE_ROUTE = "/edit_car";
const EDITCAR_MORECHOICE_ROUTE = "/edit_morechoice";
const EDITCAR_SHOWINFO_ROUTE = "/edit_showinfo";

// font size
const fontSizeXl = 18.0;
const fontSizeL = 16.0;
const fontSizeM = 14.0;
const fontSizeS = 12.0;

// color that use in app
const textColorBlack = Color(0xff38454C);
const codeColorBlack = "#38454C";
const codeColorGray = '#C4C4C4';
const codeColorRed = '#DA5B49';
const textColorWhite = Colors.white;
const textColorRed = Color(0xffDA5B49);

const primaryColor = Color(0xffFECE2F);
const colorGray = Color(0xffC4C4C4);
const bgColor = Color(0xffF2F4F6);
const bgColorRed = Color(0xffDA5B49);
const bgCodeColor = '#F2F4F6';
const primaryCodeColor = '#FECE2F';

const iconColorBlack = Color(0xff38454C);
const iconColorWhite = Colors.white;
const iconColorRed = Color(0xffDA5B49);

const cardColor = Colors.white;

// color status
const redStatus = Colors.red;
const greenStatus = Colors.green;

// Style
const boxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.25),
  blurRadius: 6,
  offset: Offset(0, 2),
);
const borderRadiusHight = BorderRadius.all(Radius.circular(25));
const borderRadiusMedium = BorderRadius.all(Radius.circular(10));
const borderRadiusLow = BorderRadius.all(Radius.circular(5));

// borderRadiusOnlyBottom
const borderRadiusLowOnlyBottom = BorderRadius.only(
    bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5));
const borderRadiusMediumOnlyBottom = BorderRadius.only(
    bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
const borderRadiusHightOnlyBottom = BorderRadius.only(
    bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25));

// borderRadiusOnlyTop
const borderRadiusLowOnlyTop = BorderRadius.only(
    topLeft: Radius.circular(5), topRight: Radius.circular(5));
const borderRadiusMediumOnlyTop = BorderRadius.only(
    topLeft: Radius.circular(10), topRight: Radius.circular(10));
const borderRadiusHightOnlyTop = BorderRadius.only(
    topLeft: Radius.circular(25), topRight: Radius.circular(25));

// card stlye
const cardWidthMedium = 320.0;
const cardWidthLow = 290.0;
const cardWidthLarge = 350.0;

// button Stlye
const buttonWidthSmall = 100.0;
const buttonHeightSmall = 40.0;

const buttonHeightMedium = 50.0;
const buttonWidthMedium = 250.0;

const buttonHeightLarge = 50.0;
const buttonWidthLarge = 350.0;

ButtonStyle flatButtonStyle(Color bgColor, Color textColor) {
  return TextButton.styleFrom(
    backgroundColor: bgColor,
    primary: textColor,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: borderRadiusMedium,
    ),
  );
}

// margin, padding
const defualtPaddingMedium = 20.0;
const defualtPaddingHight = 30.0;
const defualtPaddingLow = 10.0;

// message, wording
const mError = "บริการขัดข้อง โปรดลองอีกครั้ง";
const mNoGarages = "ไม่พบร้านให้บริการ";
const mNoMoreGarages = "สิ้นสุดรายการ";
const mLoading = "กำลังโหลด";
const mNotFound = "ไม่พบ";
const mErrorInputPhone = 'โืปดระบุเบอร์โทรศัพท์';

// src string for set widget
String tImageAsset(String imageName) {
  return 'assets/images/icon-' + imageName + '.png';
}

const tUpdateTrackingStatus = 'คุณต้องการอัพเดตใช้ไหม?';
const tOKThai = 'ตกลง';
const tInSeriveThai = 'กำลังให้บริการ';
const tBackToHomePage = 'กลับสู่หน้าหลัก';
const tServiceThai = 'บริการ';
const tFinishProvideService = 'การให้บริการเสร็จสิ้นแล้ว!';
const tMoreInfoThai = 'รายละเอียดเพิ่มเติม';
const tConfirmSuccessThai = 'ยืนยันเสร็จสิ้นการบริการ';
const tServiceOfGarageThai = 'บริการของร้าน';
const tCallbackForMoreInfo = 'ติดต่อกลับเพื่อสอบถามรายละเอียด';
const tYouWantCancleThai = 'ท่านต้องการยกเลิกหรือไม่';
const tWaitForGarageThai = 'ยืนยันคำขอ รอตอบรับ';
const tAlertRequestService = 'มีคนต้องการความช่วยเหลือ!';
const tRequestServiceThai = 'ขอบริการตอนนี้';
const tConfirm = 'ยืนยัน';
const tDeclineThai = 'ปฏิเสธิ';
const tAddressThai = 'ที่อยู่: ';
const tUpdateThai = 'อัพเดต';
const tCancleThai = 'ยกเลิก';
const tRemove = 'เอาออก';
const tDelete = 'ลบ';
const tEdit = 'แก้ไข';
const tAcceptThai = 'ยอมรับ';
const tSupportThai = 'ติดต่อซัพพอร์ท';
const tYesThai = 'ใช้';
const tMessage = "messages";
const tAddCar = 'เพื่มรถยนตร์';
const tEmail = "อีเมล";
const tBrand = 'ยี่ห้อ: ';
const tPhone = 'โทรศัพท์';
const tModel = 'รุ่น: ';
const tNext = 'ถัดไป';
const tYearModel = 'ปี: ';
const tFuelType = 'เชื้อเพลิง: ';
const tPassword = "รหัสผ่าน: ";
const tSearch = 'ค้นหา';
const tNameGarageThai = "ชื่ออู๋:";
const tNameUserThai = "ชื่อลูกค้า:";
const tLocationThai = 'ตำแหน่ง:';
const tProblemThai = 'ปัญหา:';
const tPlearInputInfo = 'คุณเพิ่มข้อมูลไม่ครบ!';
const tEstimateDuration = 'ระยะเวลาประมาณ:';
const tGiveScore = 'ให้คะแนน';
const tSend = 'ส่ง';
const tNotAtMoment = 'ไม่ใช้ตอนนี้';
const tSelectVehicleTypeCar = 'เลือกชนิดของรถยนตร์';
const tSelectBrandCar = 'เลือกยี่ห้อของรถยนตร์';
const tSelectModelCar = 'เลือกรุ่นของรถยนตร์';
const tEditCar = 'แก้ไขรถยนตร์';
const tDeleteThisCar = 'ลบรถคันนี้';
const tSelectCarForRequest = 'เลือกรถของคุณ';
const tEditThisCar = 'แก้ไขรถคันนี้';
const tSelectYearModelCar = 'เลือกปี่ยี่ห้อของรถยนตร์';
const tSelectFeulTypeCar = 'เลือกชนิดเชื้อเพลิงของรถยนตร์';
const tInfoNewcar = 'ข้อมูลรถคันใหม่ของคุณ';
const tInfoEditcar = 'ข้อมูลใหม่รถของคุณ';
const tRegistration = 'สร้างบัญชี';
const tAppName = 'รถเสีย';
const tLogin = 'เข้าสู่ระบบ';

//Tracking Status
const trackingStatus = [
  'กำลังเตรียมของ',
  'กำลังเดินทาง',
  'ถึงที่หมายแล้ว',
  'งานเสร็จแล้ว'
];

//menus setting
const menusSetting = [
  'โปรไฟล์',
  'ประวัติการใช้งาน',
  'การตั้งค่า',
  'ออกจากระบบ'
];

//vehicle type
const vehicleType = [
  'two-wheel',
  'three-wheel',
  'four-wheel',
  'heavy-wheel',
];

const fuelTypeCar = ['Prtrol', 'Diesel', 'Gas', 'Electic'];

List<Car> mockUpCar = [
  Car(
      id: "1",
      brand: 'Honda',
      model: 'Civic',
      type: 'four-wheel',
      year: '2010',
      fuelType: 'Gas'),
  Car(
      id: "2",
      brand: 'Mazda',
      model: '2',
      type: 'four-wheel',
      year: '2020',
      fuelType: 'Desel'),
  Car(
      id: "3",
      brand: 'Yamaha',
      model: 'scoopy-i',
      type: 'two-wheel',
      year: '2013',
      fuelType: 'Gasoho'),
];
DateTime mockupDateTime = DateTime(2017, 9, 7, 17, 30);
User mockUpUser = User(
    id: '1',
    name: 'Jorge Dennel',
    email: 'JorgeDennel@mail.com',
    phone: '06155648451',
    password: '1234',
    otp: '1234',
    validatePhone: true,
    cars: mockUpCar);

final brandCar = [
  'Mazda',
  'Honda',
  'Yamaha',
  'Toyota',
];
final modelCar = ['Civic', 'Jazz', 'Scoopy-I', 'Fg33', 'Kerry-2'];

final yearModelCar = [
  '2010',
  '2012',
  '2013',
  '2014',
  '2015',
  '2016',
  '2017',
  '2018'
];
