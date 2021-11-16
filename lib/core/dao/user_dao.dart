import 'package:rodsiaapp/core/database/user_database.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';
import 'package:rodsiaapp/main.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(UserDB user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<UserDB> getUserToken() async {
    final db = await dbProvider.database;
    UserDB userDB;
    try {
      List<Map<String, dynamic>> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [0]);
      if (users.length > 0) {
        //users.forEach((row) => logger.d('getUserToken: ${row}'));
        userDB = UserDB.fromDatabaseJson(users[0]);
        logger.d('getUserToken: ${userDB}');
        return userDB;
      } else {
        return null!;
      }
    } catch (error) {
      return null!;
    }
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
