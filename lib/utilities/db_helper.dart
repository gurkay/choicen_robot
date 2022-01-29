import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  // USER TABLE
  String userTable = 'userTable';
  String colUserId = 'userId';
  String colUserEmail = 'userEmail';
  String colUserPassword = 'userPassword';

  // CATEGORY TABLE
  String categoryTable = 'categoryTable';
  String colCategoryId = 'categoryId';
  String colUserTableUserId = 'userId';
  String colCategoryName = 'categoryName';

  // ACTIVITY TABLE
  String activityTable = 'activityTable';
  String colActivityId = 'activityId';
  String colCategoryTableCategoryId = 'categoryId';
  String colActivityName = 'activityName';

  // CRITERIA TABLE
  String criteriaTable = 'criteriaTable';
  String colCriteriaId = 'criteriaId';
  String colCatTableCategoryId = 'categoryId';
  String colCriteriaName = 'criteriaName';
  String colCriteriaBigValuePerfect = 'criteriaBigValuePerfect';

  // CONCLUTION TABLE
  String conclutionTable = 'conclutionTable';
  String colConclutionId = 'conclutionId';
  String colCatTabCategoryId = 'categoryId';
  String colConclutionName = 'conclutionName';
  String colConclutionDate = 'conclutionDate';

  // CALCULATE TABLE
  String calculateTable = 'calculateTable';
  String colCalculateId = 'calculateId';
  String colUserTabUserId = 'userId';
  String colConclutionTableConclutionId = 'conclutionId';
  String colActivityTableActivityId = 'activityId';
  String colCriteriaTableCriteriaId = 'criteriaId';
  String colCalculateAmount = 'calculateAmount';

  // CONCLUTION FINISH TABLE
  String conclutionFinishTable = 'conclutionFinishTable';
  String colConclutionFinishId = 'conclutionFinishId';
  String colConclutionTabConclutionId = 'conclutionId';
  String colActivityTableActivityName = 'activityName';
  String colConclutionFinishValue = 'conclutionFinishValue';

  static final DbHelper _instance = new DbHelper.internal();
  factory DbHelper() => _instance;
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DbHelper.internal();

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'choicen_robot.db';
    var choicenRobotDatabase = await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
    );
    return choicenRobotDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    // USER TABLE CREATE
    var sqlUserTable = 'CREATE TABLE $userTable('
        '$colUserId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colUserEmail TEXT,'
        '$colUserPassword TEXT)';

    // CATEGORY TABLE CREATE
    var sqlCategoryTable = 'CREATE TABLE $categoryTable('
        '$colCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colUserTableUserId INTEGER,'
        '$colCategoryName TEXT)';

    // ACTIVITY TABLE CREATE
    var sqlActivityTable = 'CREATE TABLE $activityTable('
        '$colActivityId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colCategoryTableCategoryId INTEGER,'
        '$colActivityName TEXT)';

    // CRITERIA TABLE CREATE
    var sqlCriteriaTable = 'CREATE TABLE $criteriaTable('
        '$colCriteriaId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colCatTableCategoryId INTEGER,'
        '$colCriteriaName TEXT,'
        '$colCriteriaBigValuePerfect INTEGER)';

    // CONCLUTION TABLE CREATE
    var sqlConclutionTable = 'CREATE TABLE $conclutionTable('
        '$colConclutionId TEXT PRIMARY KEY,'
        '$colCatTabCategoryId INTEGER,'
        '$colConclutionName TEXT,'
        '$colConclutionDate TEXT)';

    // CALCULATE TABLE CREATE
    var sqlCalculateTable = 'CREATE TABLE $calculateTable('
        '$colCalculateId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colUserTabUserId INTEGER,'
        '$colConclutionTableConclutionId TEXT,'
        '$colActivityTableActivityId INTEGER,'
        '$colCriteriaTableCriteriaId INTEGER,'
        '$colCalculateAmount REAL)';

    // CONCLUTION FINISH TABLE
    var sqlConclutionFinishTable = 'CREATE TABLE $conclutionFinishTable('
        '$colConclutionFinishId TEXT PRIMARY KEY,'
        '$colConclutionTabConclutionId TEXT,'
        '$colActivityTableActivityName TEXT,'
        '$colConclutionFinishValue REAL)';

    db.execute(sqlUserTable);
    db.execute(sqlCategoryTable);
    db.execute(sqlActivityTable);
    db.execute(sqlCriteriaTable);
    db.execute(sqlConclutionTable);
    db.execute(sqlCalculateTable);
    db.execute(sqlConclutionFinishTable);
  }
}
