import 'package:http/http.dart' as http;

class Garagerepository {
  static final Garagerepository _garagerepository = Garagerepository._();
  Garagerepository._();

  String api = 'http://localhost:3000/api/garages';

  factory Garagerepository() {
    return _garagerepository;
  }

  Future<dynamic> getGarages() async {
    try {
      return await http.get(Uri.parse(api));
    } catch (e) {
      return e.toString();
    }
  }
}
