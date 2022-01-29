import 'package:choicen_robot/models/Conclution.dart';
import 'package:choicen_robot/utilities/db_helper.dart';
import 'package:choicen_robot/utilities/i_request.dart';

class RequestConclution implements IRequest {
  DbHelper dbHelper = new DbHelper();

  @override
  Future<int> delete(dynamic conclutionId) async {
    var db = await dbHelper.db;
    var result = await db!.delete(
      dbHelper.conclutionTable,
      where: '${dbHelper.colConclutionId} = ?',
      whereArgs: [conclutionId],
    );
    return result;
  }

  @override
  Future<Conclution> insert(dynamic conclution) async {
    var db = await dbHelper.db;
    var result = await db!.insert(dbHelper.conclutionTable, conclution.toMap());

    return conclution;
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

  Future<List<Conclution>> getListConclutions(String conclutionId) async {
    List<Conclution> Conclutions = <Conclution>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>> result = await db!.query(
      dbHelper.ConclutionTable,
      where: '${dbHelper.colConclutionId} = ?',
      whereArgs: [conclutionId],
    );
    var count = result.length;
    for (var i = 0; i < count; i++) {
      Conclutions.add(Conclution.fromMapObject(result[i]));
    }
    return Conclutions;
  }
}
