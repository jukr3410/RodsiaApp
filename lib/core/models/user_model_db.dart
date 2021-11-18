class UserDB {
  int id;
  String? user_id;
  String phone;
  String? token;

  UserDB({required this.id, this.user_id, required this.phone, this.token});

  factory UserDB.fromDatabaseJson(Map<String, dynamic> data) => UserDB(
        id: data['id'],
        user_id: data['user_id'],
        phone: data['phone'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "user_id": this.user_id,
        "phone": this.phone,
        "token": this.token
      };
}
