import 'package:choicen_robot/models/user.dart';
import 'package:choicen_robot/utilities/db_helper.dart';
import 'package:choicen_robot/utilities/i_request.dart';

class RequestUser implements IRequest {
  DbHelper dbHelper = new DbHelper();

  @override
  delete(data) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<User?> insert(dynamic newUser) async {
    User user = newUser;
    var db = await dbHelper.db;
    await db!.insert(dbHelper.userTable, user.toMap());
    return user;
  }

  @override
  Future<List<User>> read(dynamic findUser) async {
    User fUser = findUser;
    List<User> user = <User>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>>? result = await db?.query(
      dbHelper.userTable,
      where: '${dbHelper.colUserEmail} = ? and ${dbHelper.colUserPassword} = ?',
      whereArgs: [fUser.userEmail, fUser.userPassword],
    );
    var count = result!.length;
    for (var i = 0; i < count; i++) {
      user.add(User.fromMapObject(result[i]));
    }
    return user;
  }

  @override
  update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
