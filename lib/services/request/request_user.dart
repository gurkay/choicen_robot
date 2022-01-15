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
  Future<User> insert(dynamic user) async {
    print('request_user:::insert:::userEmail: ${user.userEmail}');
    print('request_user:::insert:::userPassword: ${user.userPassword}');
    var db = await dbHelper.db;
    var result = await db!.insert(dbHelper.userTable, user.toMap());
    print('request_user:::insert:::result: ${result}');
    User _user = User.withUserId(result, user.userEmail, user.userPassword);
    print('request_user:::insert:::_user: ${_user.userId}');
    return _user;
  }

  @override
  Future<User> read(dynamic user) async {
    List<User> _listUser = <User>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>>? result = await db?.query(
      dbHelper.userTable,
      where: '${dbHelper.colUserEmail} = ? and ${dbHelper.colUserPassword} = ?',
      whereArgs: [user.userEmail, user.userPassword],
    );
    var count = result!.length;
    for (var i = 0; i < count; i++) {
      _listUser.add(User.fromMapObject(result[i]));
    }
    return User.fromMapObject(result[0]);
  }

  @override
  update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
