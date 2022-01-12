class Activity {
  int? _activityId;
  int? _categoryId;
  String? _activityName;

  Activity(
    this._categoryId,
    this._activityName,
  );

  Activity.withActivityId(
    this._activityId,
    this._categoryId,
    this._activityName,
  );

  int get activityId => _activityId ?? 0;

  int get categoryId => _categoryId ?? 0;
  set categoryId(int newCategoryId) {
    if (newCategoryId != 0) {
      this._categoryId = newCategoryId;
    }
  }

  String get activityName => _activityName ?? 'activity null value return';
  set activityName(String newActivityName) {
    if (newActivityName.length < 200) {
      this._activityName = newActivityName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_activityId != null) {
      map['activityId'] = _activityId;
    }
    map['categoryId'] = _categoryId;
    map['activityName'] = _activityName;
    return map;
  }

  Activity.fromMapObject(Map<String, dynamic> map) {
    _activityId = map['activityId'];
    _categoryId = map['categoryId'];
    _activityName = map['activityName'];
  }
}
