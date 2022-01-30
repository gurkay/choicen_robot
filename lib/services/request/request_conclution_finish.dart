import 'package:choicen_robot/models/conclution_finish.dart';
import 'package:choicen_robot/utilities/db_helper.dart';
import 'package:choicen_robot/utilities/i_request.dart';

class RequestConclutionFinish implements IRequest {
  DbHelper dbHelper = new DbHelper();

  @override
  Future<int> delete(dynamic conclutionFinishId) async {
    var db = await dbHelper.db;
    var result = await db!.delete(
      dbHelper.conclutionFinishTable,
      where: '${dbHelper.colConclutionFinishId} = ?',
      whereArgs: [conclutionFinishId],
    );
    return result;
  }

  @override
  Future<ConclutionFinish> insert(dynamic conclutionFinish) async {
    var db = await dbHelper.db;
    var result = await db!
        .insert(dbHelper.conclutionFinishTable, conclutionFinish.toMap());
    ConclutionFinish _conclutionFinish =
        ConclutionFinish.withConclutionFinishId(
      conclutionFinish.conclutionFinishId,
      conclutionFinish.conclutionId,
      conclutionFinish.activityName,
      conclutionFinish.conclutionFinishValue,
    );

    return _conclutionFinish;
  }

  @override
  read(data) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<List<ConclutionFinish>> getListConclutionFinies(
      String conclutionId) async {
    List<ConclutionFinish> _conclutionFinies = <ConclutionFinish>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>> result = await db!.query(
      dbHelper.conclutionFinishTable,
      where: '${dbHelper.colConclutionId} = ?',
      whereArgs: [conclutionId],
    );

    for (var i = 0; i < result.length; i++) {
      _conclutionFinies.add(ConclutionFinish.fromMapObject(result[i]));
    }
    return _conclutionFinies;
  }
}
