import '../../models/conclution.dart';
import '../../utilities/db_helper.dart';
import '../../utilities/i_request.dart';

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
    print(
        'request_conclution:::insert:::conclution.id:::${conclution.conclutionId}');

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
  Future<int> update(dynamic conclution) async {
    var db = await dbHelper.db;
    var result = await db!.update(
      dbHelper.conclutionTable,
      conclution.toMap(),
      where: '${dbHelper.colConclutionId} = ?',
      whereArgs: [conclution.conclutionId],
    );
    return result;
  }

  Future<List<Conclution>> getListConclutions(int categoryId) async {
    List<Conclution> _conclutions = <Conclution>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>> result = await db!.query(
      dbHelper.conclutionTable,
      where: '${dbHelper.colCatTabCategoryId} = ?',
      whereArgs: [categoryId],
    );

    for (var i = 0; i < result.length; i++) {
      _conclutions.add(Conclution.fromMapObject(result[i]));
    }
    return _conclutions;
  }
}
