class UserLogin {
  String phone;
  String password;

  UserLogin({required this.phone, required this.password});

  Map<String, dynamic> toJson() =>
      {"phone": this.phone, "password": this.password};
}

class Token {
  String user_id;
  String token;

  Token({required this.token, required this.user_id});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token'], user_id: json['user_id']);
  }
}
