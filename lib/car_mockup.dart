class CarDetail {
  final String carType;
  final List<CarBrandModel> datail;
  CarDetail({required this.datail, required this.carType});
}

class CarBrandModel {
  final String brand;
  final List<String> model;
  CarBrandModel({required this.brand, required this.model});
}

List<CarBrandModel> twoWheelCars = [
  CarBrandModel(brand: 'BMW', model: [
    'S-1000-RR',
    'R-1250-RT',
    'K-1600-b',
    'K-1600-GA',
    'G-310-R',
    'S-1000-R',
    'F-900-R'
  ]),
  CarBrandModel(brand: 'Ducati', model: [
    'Diavel',
    'Hypermotard',
    'Monster',
    'Multistrada',
    'Panigale',
    'Scrambler',
    'Streetfighter',
    'SuperSport'
  ]),
  CarBrandModel(brand: 'Honda', model: [
    'Scoopy',
    'Pcx160',
    'Forza 350',
    'LEAD125',
    'ADV150',
    'Click 150i',
    'Click 125i',
    'Click 125i'
  ]),
  CarBrandModel(
      brand: 'Kawasaki',
      model: ['D-Tracker', 'KLR', 'KLK', 'KX', 'MEGURO', 'Vulcan', 'Versys']),
  CarBrandModel(brand: 'Yamaha', model: [
    'WR155R',
    'NMAX',
    'XMAX',
    'KX',
    'Grand Filano',
    'Finn',
    'YZF-R3',
    'MT-03',
    'Exciter',
    'QBIX',
    'Fino',
    'Freego'
  ]),
];

List<CarBrandModel> threeWheelCars = [
  CarBrandModel(brand: 'TUK-TUK', model: ['TUK-TUK'])
];
List<CarBrandModel> fourWheelCars = [
  CarBrandModel(brand: 'TOYOTA', model: [
    'TOYOTA',
    'Vios',
    'Altis',
    'C-HR',
    'Corolla Cross',
    'Camry',
    'GR supra',
    'Hilux Revo',
    'Commuter',
    'Hiace',
    'Avanza',
    'SlantaInnava Crysta',
    'Fortuner',
    'Majesty',
    'Coaster',
    'Alphard'
  ]),
  CarBrandModel(brand: 'ISUZU', model: [
    'X-serie',
    'V-cross',
    'Spark',
    'All-NEW-MU-X',
    'D-MAX',
  ]),
  CarBrandModel(brand: 'HONDA', model: [
    'HR-V',
    'Civic',
    'Accord',
    'City',
    'Jazz',
    'CR-V',
    'BR-V',
    'Mobilio'
  ]),
  CarBrandModel(brand: 'MITSUBISHI', model: [
    'Pajaro Sport',
    'Titan',
    'Xpander-Cross',
    'Xpander',
    'Mirag',
    'Attract',
    'PSEV',
  ]),
  CarBrandModel(brand: 'NISSAN', model: [
    'Navara',
    'GT-R',
    'March',
    'Note',
    'Almera',
    'TERRA',
    'LEAF',
    'URVAN'
  ]),
  CarBrandModel(brand: 'MAZDA', model: [
    'MAZDA2',
    'MAZDA3',
    'CX-3',
    'CX-5',
    'CX-8',
    'BT-50',
  ]),
  CarBrandModel(brand: 'FORD ', model: [
    'Mustang',
    'Everest',
    'Ranger',
    'Raptor-x',
    'FX4Max',
  ]),
  CarBrandModel(brand: 'MG', model: [
    'MG5',
    'MG-ZS',
    'MG3',
    'MG-HS',
    'MG-HS-PHEV',
    'MG-ZS-EV',
    'MG-EP',
    'EXtender'
  ]),
  CarBrandModel(brand: 'SUZUKI', model: [
    'Swift',
    'Ciaz',
    'XL7',
    'Celerio',
    'Ertiga',
  ]),
];
List<CarBrandModel> heavyWheelCars = [
  CarBrandModel(brand: 'ISUZU', model: ['King-of-trucks']),
  CarBrandModel(brand: 'HINO', model: ['XZU', 'FC', 'FL', 'FG', 'FM', 'GY']),
  CarBrandModel(brand: 'SUZUKI', model: ['Carry']),
];

List<CarDetail> carMockup = [
  CarDetail(datail: twoWheelCars, carType: 'two-wheel'),
  CarDetail(datail: threeWheelCars, carType: 'three-wheel'),
  CarDetail(datail: fourWheelCars, carType: 'four-wheel'),
  CarDetail(datail: heavyWheelCars, carType: 'heavy-wheel'),
];
