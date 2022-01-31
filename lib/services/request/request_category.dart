import '../../models/category.dart';
import '../../utilities/db_helper.dart';
import '../../utilities/i_request.dart';

class RequestCategory implements IRequest {
  DbHelper dbHelper = new DbHelper();
  @override
  Future<int> delete(dynamic categoryId) async {
    var db = await dbHelper.db;
    var result = await db!.delete(
      dbHelper.categoryTable,
      where: '${dbHelper.colCategoryId} = ?',
      whereArgs: [categoryId],
    );
    await db.delete(
      dbHelper.activityTable,
      where: '${dbHelper.colCategoryId} = ?',
      whereArgs: [categoryId],
    );
    await db.delete(
      dbHelper.criteriaTable,
      where: '${dbHelper.colCategoryId} = ?',
      whereArgs: [categoryId],
    );
    return result;
  }

  @override
  Future<Category> insert(dynamic category) async {
    var db = await dbHelper.db;
    var result = await db!.insert(dbHelper.categoryTable, category.toMap());
    Category _category = Category.withCategoryId(
      result,
      category.userId,
      category.categoryName,
    );
    return _category;
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

  Future<List<Category>> getListCategory(int userId) async {
    List<Category> category = <Category>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>> result = await db!.query(
      dbHelper.categoryTable,
      where: '${dbHelper.colUserId} = ?',
      whereArgs: [userId],
    );
    var count = result.length;
    for (var i = 0; i < count; i++) {
      category.add(Category.fromMapObject(result[i]));
    }
    return category;
  }
}
