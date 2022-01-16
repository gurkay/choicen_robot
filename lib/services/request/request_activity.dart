import 'package:choicen_robot/models/activity.dart';
import 'package:choicen_robot/utilities/db_helper.dart';
import 'package:choicen_robot/utilities/i_request.dart';

class RequestActivity implements IRequest {
  DbHelper dbHelper = new DbHelper();

  @override
  Future<int> delete(dynamic activityId) async {
    var db = await dbHelper.db;
    var result = await db!.delete(
      dbHelper.activityTable,
      where: '${dbHelper.colActivityId} = ?',
      whereArgs: [activityId],
    );
    return result;
  }

  @override
  Future<Activity> insert(dynamic activity) async {
    var db = await dbHelper.db;
    var result = await db!.insert(dbHelper.activityTable, activity.toMap());
    Activity _activity = Activity.withActivityId(
      result,
      activity.categoryId,
      activity.activityName,
    );
    return _activity;
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

  Future<List<Activity>> getListActivities(int categoryId) async {
    List<Activity> activities = <Activity>[];
    var db = await dbHelper.db;
    List<Map<String, Object?>> result = await db!.query(
      dbHelper.activityTable,
      where: '${dbHelper.colCategoryId} = ?',
      whereArgs: [categoryId],
    );
    var count = result.length;
    for (var i = 0; i < count; i++) {
      activities.add(Activity.fromMapObject(result[i]));
    }
    return activities;
  }
}
