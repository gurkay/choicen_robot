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
    print(
        'request_calculate:::insert:::calculate.userId:::${calculate.userId}');
    print(
        'request_calculate:::insert:::calculate.conclutionId:::${calculate.conclutionId}');
    print(
        'request_calculate:::insert:::calculate.activityId:::${calculate.activityId}');
    print(
        'request_calculate:::insert:::calculate.criteriaId:::${calculate.criteriaId}');
    print(
        'request_calculate:::insert:::calculate.amount:::${calculate.amount}');
    var calMap = calculate.toMap();
    print('request_calculate:::insert:::calMap[userId]:::${calMap['userId']}');
    print(
        'request_calculate:::insert:::calMap[conclutionId]:::${calMap['conclutionId']}');
    print(
        'request_calculate:::insert:::calMap[activityId]:::${calMap['activityId']}');
    print(
        'request_calculate:::insert:::calMap[criteriaId]:::${calMap['criteriaId']}');
    print('request_calculate:::insert:::calMap[amount]:::${calMap['amount']}');
    int result = await db!.insert(dbHelper.calculateTable, calculate.toMap());
    print('request_calculate:::insert:::result:::${result}');
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
    List<Calculate> _calculates = <Calculate>[];
    var db = await dbHelper.db;
    print(
        'request_calculate:::getListCalculates:::conclutionId::${conclutionId}');
    print(
        'request_calculate:::getListCalculates:::dbHelper.colConclutionTableConclutionId::${dbHelper.colConclutionTableConclutionId}');
    List<Map<String, Object?>> result =
        await db!.rawQuery('SELECT * FROM ${dbHelper.calculateTable}');
    print(
        'request_calculate:::getListCalculates:::result.lenght::${result.length}');
    for (var i = 0; i < result.length; i++) {
      _calculates.add(Calculate.fromMapObject(result[i]));
    }
    return _calculates;
  }
}
