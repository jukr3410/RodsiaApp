class Garage {
  late String name;
  late String phone;
  late String email;
  late Address address;
  late OpeningHour openingHour;
  late String logoImage;
  late List<String> image;

  Garage(
      {required this.name,
      required this.phone,
      required this.email,
      required this.address,
      required this.openingHour,
      required this.logoImage,
      required this.image});

  Garage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = (json['address'] != null
        ? new Address.fromJson(json['address'])
        : null)!;
    openingHour = (json['openingHour'] != null
        ? new OpeningHour.fromJson(json['openingHour'])
        : null)!;
    logoImage = json['logo_image'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address.toJson();
    data['openingHour'] = this.openingHour.toJson();
    data['logo_image'] = this.logoImage;
    data['image'] = this.image;
    return data;
  }
}

class Address {
  late String addressDesc;
  late Geolocation geolocation;

  Address({required this.addressDesc, required this.geolocation});

  Address.fromJson(Map<String, dynamic> json) {
    addressDesc = json['addressDesc'];
    geolocation = (json['geolocation'] != null
        ? new Geolocation.fromJson(json['geolocation'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressDesc'] = this.addressDesc;
    data['geolocation'] = this.geolocation.toJson();
    return data;
  }
}

class Geolocation {
  late String lat;
  late String long;

  Geolocation({required this.lat, required this.long});

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class OpeningHour {
  late Day m;
  late Day tu;
  late Day w;
  late Day th;
  late Day f;
  late Day sa;
  late Day su;

  OpeningHour(
      {required this.m,
      required this.tu,
      required this.w,
      required this.th,
      required this.f,
      required this.sa,
      required this.su});

  OpeningHour.fromJson(Map<String, dynamic> json) {
    m = (json['m'] != null ? new Day.fromJson(json['m']) : null)!;
    tu = (json['tu'] != null ? new Day.fromJson(json['tu']) : null)!;
    w = (json['w'] != null ? new Day.fromJson(json['w']) : null)!;
    th = (json['th'] != null ? new Day.fromJson(json['th']) : null)!;
    f = (json['f'] != null ? new Day.fromJson(json['f']) : null)!;
    sa = (json['sa'] != null ? new Day.fromJson(json['sa']) : null)!;
    su = (json['su'] != null ? new Day.fromJson(json['su']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m'] = this.m.toJson();
    data['tu'] = this.tu.toJson();
    data['w'] = this.w.toJson();
    data['th'] = this.th.toJson();
    data['f'] = this.f.toJson();
    data['sa'] = this.sa.toJson();
    data['su'] = this.su.toJson();
    return data;
  }
}

class Day {
  late String open;
  late String close;

  Day({required this.open, required this.close});

  Day.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}
