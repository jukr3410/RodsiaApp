class UserDB {
  int id;
  String phone;
  //String token;

  UserDB({
    required this.id,
    required this.phone,
    //this.token
  });

  factory UserDB.fromDatabaseJson(Map<String, dynamic> data) => UserDB(
        id: data['id'],
        phone: data['phone'],
        //token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "phone": this.phone,
        //"token": this.token
      };
}
