import 'package:choicen_robot/models/criteria.dart';
import 'package:choicen_robot/utilities/db_helper.dart';
import 'package:choicen_robot/utilities/i_request.dart';

class RequestCriteria implements IRequest {
  DbHelper dbHelper = new DbHelper();

  @override
  Future<int> delete(dynamic criteriaId) async {
    var db = await dbHelper.db;
    var result = await db!.delete(
      dbHelper.criteriaTable,
      where: '${dbHelper.colCriteriaId} = ?',
      whereArgs: [criteriaId],
    );
    return result;
  }

  @override
  Future<Criteria> insert(dynamic criteria) async {
    var db = await dbHelper.db;
    var result = await db!.insert(dbHelper.criteriaTable, criteria.toMap());
    Criteria _criteria = Criteria.withCriteriaId(
      result,
      criteria.categoryId,
      criteria.criteriaName,
      criteria.criteriaBigValuePerfect,
    );
    return _criteria;
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

  Future<List<Criteria>> getListCriterias(int categoryId) async {
    List<Criteria> criterias = <Criteria>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>> result = await db!.query(
      dbHelper.criteriaTable,
      where: '${dbHelper.colCategoryId} = ?',
      whereArgs: [categoryId],
    );
    var count = result.length;
    for (var i = 0; i < count; i++) {
      criterias.add(Criteria.fromMapObject(result[i]));
    }
    return criterias;
  }
}
