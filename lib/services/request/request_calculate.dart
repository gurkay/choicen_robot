import '../../models/calculate.dart';
import '../../utilities/db_helper.dart';
import '../../utilities/i_request.dart';

class RequestCalculate implements IRequest {
  DbHelper dbHelper = new DbHelper();

  @override
  Future<int> delete(dynamic calculateId) async {
    var db = await dbHelper.db;
    var result = await db!.delete(
      dbHelper.calculateTable,
      where: '${dbHelper.colCalculateId} = ?',
      whereArgs: [calculateId],
    );
    return result;
  }

  @override
  Future<Calculate> insert(dynamic calculate) async {
    var db = await dbHelper.db;
    var result = await db!.insert(dbHelper.calculateTable, calculate.toMap());
    Calculate _calculate = Calculate.withCalculateId(
      result,
      calculate.userId,
      calculate.conclutionId,
      calculate.activityId,
      calculate.criteriaId,
      calculate.amount,
    );
    return _calculate;
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

  Future<List<Calculate>> getListCalculates(String conclutionId) async {
    List<Calculate> calculates = <Calculate>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>> result = await db!.query(
      dbHelper.calculateTable,
      where: '${dbHelper.colConclutionId} = ?',
      whereArgs: [conclutionId],
    );
    var count = result.length;
    for (var i = 0; i < count; i++) {
      calculates.add(Calculate.fromMapObject(result[i]));
    }
    return calculates;
  }
}
