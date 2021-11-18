import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/notify_feature/widgets/notifyPage.dart';

import 'core/models/car_model.dart';

//api base url
//dev localhost api
// final baseUrlConstant = "http://localhost:3000/api";
// final baseUrlConstantSockertIO = "http://localhost:3000/";

// production api
final baseUrlConstant = 'https://rodsia-api.herokuapp.com/api';

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
const REQUEST_COMPLETE_ROUTE = "/complete_request";
const EDITCAR_CARTYPE_ROUTE = "/edit_car";
const EDITCAR_MORECHOICE_ROUTE = "/edit_morechoice";
const EDITCAR_SHOWINFO_ROUTE = "/edit_showinfo";
const SHOWINFO_BEFOREREQ_ROUTE = '/showinfo_befor_request';
const EDITPROFILE_ROUTE = '/edit_profile';
const CHAT_ROUTE = '/chat';
const FIND_PROBLEM = '/find_problem';
const SUPPORT_CENTER_ROUTE = '/support_center';
const NOTIFY_ROUTE = '/notify';
const GARAGE_SEARCH_ROUTE = 'garage-search';

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
const mErrorInputPhone = 'โปดระบุเบอร์โทรศัพท์';

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
const tPassword = "รหัสผ่าน ";
const tConfirmPassword = "ยืนยันรหัสผ่าน ";
const tSearch = 'ค้นหา';
const tNameGarageThai = "ชื่ออู๋:";
const tNameUserThai = "ชื่อลูกค้า:";
const tLocationThai = 'ตำแหน่ง:';
const tLocationCurrent = 'ตำแหน่งปัจจุบัน';
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
const tRecapOrder = 'สรุปรายการ';
const tSentMsg = 'ส่งข้อความ';

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
  'ศูยน์ช่วยเหลือ',
  'chat test',
  'การตั้งค่า',
  'ออกจากระบบ'
];
const menusSettingRoute = [
  PROFILE_ROUTE,
  SUPPORT_CENTER_ROUTE,
  CHAT_ROUTE,
  PROFILE_ROUTE,
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
      fuelType: 'Gas',
      regisNumber: 'กง1123'),
  Car(
      id: "2",
      brand: 'Mazda',
      model: '2',
      type: 'four-wheel',
      year: '2020',
      fuelType: 'Desel',
      regisNumber: 'กง1123'),
  Car(
      id: "3",
      brand: 'Yamaha',
      model: 'scoopy-i',
      type: 'two-wheel',
      year: '2013',
      fuelType: 'Gasoho',
      regisNumber: "GG5552"),
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
    cars: mockUpCar,
    profileImage: 'https://files.gqthailand.com/uploads/Johnny-Depp.jpg');

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
List<String> serviceType = [
  'battery',
  'tire',
  'break',
  'keydoorcar',
  'rickshaw',
  'fuel',
];
List<String> serviceTypeName = [
  'แบตเตอรี่',
  'ยาง',
  'เบรก',
  'ประตูกุญแจ',
  'รถยก',
  'น้ำมัน',
];
// Garage garageMockup = Garage(
//     images: [],
//     id: '1',
//     name: 'Garage1892',
//     phone: '0359887456',
//     email: "email@mail.com",
//     address: Address(
//       addressDesc: '',
//       geoLocation: GeoLocation(lat: 'asdf', long: 'asdfasdf'),
//     ));
List<String> mockupFindProblem = [
  'คุณรู้สึกอะไร?',
  'คุณได้ยินอะไร?',
  'คุณเห็นอะไร?',
  'คุณได้กลิ่นอะไร?',
  'เกิดอะไรขึ้นเมื่อคุณติดรถ?'
];
List<String> mockupNameFindProblem = [
  'hand',
  'ear',
  'eye',
  'nose',
  'startEngine'
];

class FindProblem {
  final int id;
  final String datail;
  const FindProblem({required this.id, required this.datail});
}

List<FindProblem> mockupChoiceFindProblem = [
  FindProblem(id: 1, datail: 'Drift -- Gruadual movement to one sides.'),
  FindProblem(
      id: 1,
      datail:
          'Excessive -- Looseness, lack of response in the steering wheel.'),
  FindProblem(id: 1, datail: 'Pulls -- Sharp movement to one sides.'),
  FindProblem(
      id: 1,
      datail:
          'Pulsation -- Fluctuation of the brakw pedal when the brakes are appiled.'),
  FindProblem(
      id: 1,
      datail: 'Shimmy -- Rapid side to side movement of the fronts wheels.'),
  FindProblem(
      id: 1, datail: 'Sways -- Gruadual movement to one sides to side.'),
  FindProblem(
      id: 1,
      datail:
          'Vibration -- Vehicle shakes. Usually felt in the steering wheel or the seat.'),
  FindProblem(id: 2, datail: 'Squeal -- Continuous high pitched sound.'),
  FindProblem(
      id: 2,
      datail: 'Knock -- Heavy loud repeating sound like a knock on the door.'),
  FindProblem(
      id: 2, datail: 'Tap -- Light repetitive sound, louder than a click.'),
  FindProblem(
      id: 2, datail: 'Rattle -- Marbles in a can like something loose.'),
  FindProblem(
      id: 2,
      datail:
          'Chrirp -- High-piched rapidly repeating sould, like birds chrping.'),
  FindProblem(id: 2, datail: 'Clunk -- A random thumping sound.'),
  FindProblem(id: 2, datail: 'Hiss -- Continuous sound like air eacaping.'),
  FindProblem(id: 3, datail: 'Smoke.'),
  FindProblem(id: 3, datail: 'Tire looks flat.'),
  FindProblem(id: 3, datail: 'Warning light is on.'),
  FindProblem(id: 3, datail: 'Puddle or leak.'),
  FindProblem(id: 4, datail: 'Gasoline.'),
  FindProblem(id: 4, datail: 'Rotten.'),
  FindProblem(id: 4, datail: 'Mildew.'),
  FindProblem(id: 4, datail: 'Antifreeze (sweet smell).'),
  FindProblem(id: 4, datail: 'Burning oil.'),
  FindProblem(id: 4, datail: 'Exhaust'),
  FindProblem(id: 5, datail: 'The engine cranks normally but does not start'),
  FindProblem(id: 5, datail: 'The engine cranks over slowly'),
  FindProblem(id: 5, datail: 'The vehicle is backfiring when trying to start'),
  FindProblem(id: 5, datail: 'Nothing'),
  FindProblem(id: 5, datail: 'One strong click or knock'),
  FindProblem(id: 5, datail: 'A spinning whirling, or gear grinding sound'),
  FindProblem(
      id: 5, datail: 'Repeating clicking sound: "click, click, click".'),
];

class FindProblemDetail {
  final String title;
  final String datail;
  const FindProblemDetail({required this.title, required this.datail});
}

List<FindProblemDetail> mockupFindProblemDetail = [
  FindProblemDetail(
      title: 'Loose or Worn Front End Component.',
      datail: 'Suspersion Inspection.'),
  FindProblemDetail(title: 'Uneven Tire Presure.', datail: 'TPMS Repair.'),
  FindProblemDetail(
      title: 'Four-Wheel Alignment.', datail: 'Four-Wheel Alignment.'),
];

List<NotifyInfo> mockupNotify = [
  NotifyInfo(
      typeNotify: 'โปรโมชั่น',
      title: 'ส่วนลดพิเศษประจำสัปดาห์',
      desc: [
        'เพียงใส่โค้ดส่วนลด RODSIANEW ท่านก็จะได้รับส่วนลด 20% สำหรับ ลูกค้าใหม่และ RODSIAAPP สำหรับลูกค้าเก่าจะได้รับส่วนลด 10%',
      ],
      image:
          'https://hoonhoonbeauty.com/wp-content/uploads/2017/04/AdobeStock_262035364_Promotion-1024x382.jpeg',
      startDate: DateTime(2021, 10, 1),
      endDate: DateTime(2021, 10, 15),
      condition: [
        'เงื่อนไปเป็นไปตามที่บริษัทกำหนด',
        'ต้องขอบริการเป็นประเภทยาง'
      ]),
  NotifyInfo(
      typeNotify: 'อัพเดต',
      title: 'อัพเดตเวอร์ชั้นล่าสุด',
      desc: [
        'เป็นเวอร์ชั้นที่มีการพัฒนาเรื่องความปลอดภัย เพิ่มความแม่นยำให้การหาอู๋ซ้อมรถ เพื่อให้ลูกค้าสบายใจได้เลย',
        'อัปเดตแอป Android ด้วยตนเอง\n  1.วิธีอัปเดตแอปทีละรายการหรือหลายรายการโดยใช้แอป Google Play Store บนอุปกรณ์เคลื่อนที่มีดังนี้\n  2.เปิดแอป Google Play Store Google Play\n  3.แตะไอคอนโปรไฟล์ที่ด้านบนขวา \n  4.แตะจัดการแอปและอุปกรณ์ แอปที่พร้อมอัปเดตจะมีป้าย "มีเวอร์ชันอัปเดต"\n  5.แตะอัปเดต'
      ],
      image:
          'https://www.thrillogyproductions.com/wp-content/uploads/2018/12/Update.jpg',
      startDate: DateTime(2021, 10, 30),
      endDate: null,
      condition: [
        'คุณสามารถอัปเดต iPhone, iPad หรือ iPod touch ของคุณเป็น iOS หรือ iPadOS เวอร์ชั่นล่าสุดแบบไร้สายได้',
        'หากคุณใช้ iOS หรือ iPadOS เวอร์ชั่น 14.5 หรือใหม่กว่า คุณอาจเห็นตัวเลือกให้เลือกระหว่างการอัพเดทซอฟต์แวร์สองเวอร์ชั่น ตัวเลือกนี้ช่วยให้คุณสามารถเลือกระหว่างการอัพเดทเป็นเวอร์ชั่นล่าสุดของ iOS หรือ iPadOS 15 ทันทีที่เปิดตัว หรือใช้เป็น iOS หรือ iPadOS 14 ต่อไปในขณะที่ยังคงได้รับรายการอัพเดทความปลอดภัยที่สําคัญเป็นระยะเวลาหนึ่ง',
        'หากคุณไม่เห็นรายการอัปเดตในอุปกรณ์ คุณสามารถอัปเดตด้วยตนเองได้โดยใช้คอมพิวเตอร์ ดูวิธีอัปเดตอุปกรณ์ของคุณด้วยตนเอง หากคุณใช้ Mac ที่มี macOS Catalina หรือใหม่กว่า หรือหากคุณใช้ Mac ที่มี macOS Mojave หรือรุ่นก่อนหน้า หรือใช้ PC ที่ใช้ Windows'
      ]),
  NotifyInfo(
      typeNotify: 'โปรโมชั่น',
      title: 'ส่วนลดพิเศษประจำสัปดาห์',
      desc: [
        'เพียงใส่โค้ดส่วนลด RODSIANEW ท่านก็จะได้รับส่วนลด 20% สำหรับ ลูกค้าใหม่และ RODSIAAPP สำหรับลูกค้าเก่าจะได้รับส่วนลด 10%'
      ],
      image:
          'https://hoonhoonbeauty.com/wp-content/uploads/2017/04/AdobeStock_262035364_Promotion-1024x382.jpeg',
      startDate: DateTime(2021, 10, 1),
      endDate: DateTime(2021, 10, 15),
      condition: [
        'เงื่อนไปเป็นไปตามที่บริษัทกำหนด',
        'ต้องขอบริการเป็นประเภทยาง'
      ]),
  NotifyInfo(
      typeNotify: 'อัพเดต',
      title: 'อัพเดตเวอร์ชั้นล่าสุด',
      desc: [
        'เป็นเวอร์ชั้นที่มีการพัฒนาเรื่องความปลอดภัย เพิ่มความแม่นยำให้การหาอู๋ซ้อมรถ เพื่อให้ลูกค้าสบายใจได้เลย',
        'อัปเดตแอป Android ด้วยตนเอง\n  1.วิธีอัปเดตแอปทีละรายการหรือหลายรายการโดยใช้แอป Google Play Store บนอุปกรณ์เคลื่อนที่มีดังนี้\n  2.เปิดแอป Google Play Store Google Play\n  3.แตะไอคอนโปรไฟล์ที่ด้านบนขวา \n  4.แตะจัดการแอปและอุปกรณ์ แอปที่พร้อมอัปเดตจะมีป้าย "มีเวอร์ชันอัปเดต"\n  5.แตะอัปเดต'
      ],
      image:
          'https://www.thrillogyproductions.com/wp-content/uploads/2018/12/Update.jpg',
      startDate: DateTime(2021, 10, 30),
      endDate: null,
      condition: [
        'คุณสามารถอัปเดต iPhone, iPad หรือ iPod touch ของคุณเป็น iOS หรือ iPadOS เวอร์ชั่นล่าสุดแบบไร้สายได้',
        'หากคุณใช้ iOS หรือ iPadOS เวอร์ชั่น 14.5 หรือใหม่กว่า คุณอาจเห็นตัวเลือกให้เลือกระหว่างการอัพเดทซอฟต์แวร์สองเวอร์ชั่น ตัวเลือกนี้ช่วยให้คุณสามารถเลือกระหว่างการอัพเดทเป็นเวอร์ชั่นล่าสุดของ iOS หรือ iPadOS 15 ทันทีที่เปิดตัว หรือใช้เป็น iOS หรือ iPadOS 14 ต่อไปในขณะที่ยังคงได้รับรายการอัพเดทความปลอดภัยที่สําคัญเป็นระยะเวลาหนึ่ง',
        'หากคุณไม่เห็นรายการอัปเดตในอุปกรณ์ คุณสามารถอัปเดตด้วยตนเองได้โดยใช้คอมพิวเตอร์ ดูวิธีอัปเดตอุปกรณ์ของคุณด้วยตนเอง หากคุณใช้ Mac ที่มี macOS Catalina หรือใหม่กว่า หรือหากคุณใช้ Mac ที่มี macOS Mojave หรือรุ่นก่อนหน้า หรือใช้ PC ที่ใช้ Windows'
      ]),
];
